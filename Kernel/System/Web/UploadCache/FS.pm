# --
# Kernel/System/Web/UploadCache/FS.pm - a fs upload cache
# Copyright (C) 2001-2014 OTRS AG, http://otrs.com/
# Copyright (C) 2013-2016 Informatyka Boguslawski sp. z o.o. sp.k., http://www.ib.pl/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::System::Web::UploadCache::FS;

use strict;
use warnings;

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {};
    bless( $Self, $Type );

    # check needed objects
    for (qw(ConfigObject LogObject EncodeObject MainObject)) {
        $Self->{$_} = $Param{$_} || die "Got no $_!";
    }

    $Self->{TempDir} = $Self->{ConfigObject}->Get('TempDir') . '/upload_cache';
    if ( !-d $Self->{TempDir} ) {
        mkdir $Self->{TempDir};
    }

    return $Self;
}

sub FormIDCreate {
    my ( $Self, %Param ) = @_;

    # return requested form id
    return time() . '.' . rand(12341241);
}

sub FormIDRemove {
    my ( $Self, %Param ) = @_;

    if ( !$Param{FormID} ) {
        $Self->{LogObject}->Log( Priority => 'error', Message => 'Need FormID!' );
        return;
    }

    my $Directory = $Self->{TempDir} . '/' . $Param{FormID};
    if ( !-d $Directory ) {
        return 1;
    }

    my @List = $Self->{MainObject}->DirectoryRead(
        Directory => $Directory,
        Filter    => "*",
    );
    my @Data;
    for my $File (@List) {
        $Self->{MainObject}->FileDelete(
            Location => $File,
            DisableWarnings => $Param{DisableWarnings},
        );
    }

    if ( !rmdir($Directory) ) {
        $Self->{LogObject}->Log(
            Priority => 'error',
            Message  => "Can't remove: $Directory: $!!",
        );
    }

    return 1;
}

sub FormIDAddFile {
    my ( $Self, %Param ) = @_;

    for (qw(FormID Filename ContentType)) {
        if ( !$Param{$_} ) {
            $Self->{LogObject}->Log( Priority => 'error', Message => "Need $_!" );
            return;
        }
    }

    $Param{Content} = '' if !defined($Param{Content});

    # create content id
    my $ContentID = $Param{ContentID};
    my $Disposition = $Param{Disposition} || '';
    if ( !$ContentID && lc $Disposition eq 'inline' ) {
        my $Random = rand 999999;
        my $FQDN   = $Self->{ConfigObject}->Get('FQDN');
        $ContentID = "$Disposition$Random.$Param{FormID}\@$FQDN";
    }

    # create cache subdirectory if not exist
    my $Directory = $Self->{TempDir} . '/' . $Param{FormID};
    if ( !-d $Directory ) {

        # Create directory. This could fail if another process creates the
        #   same directory, so don't use the return value.
        File::Path::mkpath( $Directory, 0, 0770 );    ## no critic

        if ( !-d $Directory ) {
            $Self->{LogObject}->Log(
                Priority => 'error',
                Message  => "Can't create directory '$Directory': $!",
            );
            return;
        }
    }

    # files must readable for creator
    return if !$Self->{MainObject}->FileWrite(
        Directory  => $Directory,
        Filename   => "$Param{Filename}",
        Content    => \$Param{Content},
        Mode       => 'binmode',
        Permission => '640',
    );
    return if !$Self->{MainObject}->FileWrite(
        Directory  => $Directory,
        Filename   => "$Param{Filename}.ContentType",
        Content    => \$Param{ContentType},
        Mode       => 'binmode',
        Permission => '640',
    );
    return if !$Self->{MainObject}->FileWrite(
        Directory  => $Directory,
        Filename   => "$Param{Filename}.ContentID",
        Content    => \$ContentID,
        Mode       => 'binmode',
        Permission => '640',
    );
    return if !$Self->{MainObject}->FileWrite(
        Directory  => $Directory,
        Filename   => "$Param{Filename}.Disposition",
        Content    => \$Disposition,
        Mode       => 'binmode',
        Permission => '644',
    );
    return 1;
}

sub FormIDRemoveFile {
    my ( $Self, %Param ) = @_;

    for (qw(FormID FileID)) {
        if ( !$Param{$_} ) {
            $Self->{LogObject}->Log( Priority => 'error', Message => "Need $_!" );
            return;
        }
    }

    my @Index = @{ $Self->FormIDGetAllFilesMeta(%Param) };

    return if !@Index;

    my $ID    = $Param{FileID} - 1;
    my %File  = %{ $Index[$ID] };

    my $Directory = $Self->{TempDir} . '/' . $Param{FormID};
    if ( !-d $Directory ) {
        return 1;
    }

    $Self->{MainObject}->FileDelete(
        Directory => $Directory,
        Filename  => "$File{Filename}",
    );
    $Self->{MainObject}->FileDelete(
        Directory => $Directory,
        Filename  => "$File{Filename}.ContentType",
    );
    $Self->{MainObject}->FileDelete(
        Directory => $Directory,
        Filename  => "$File{Filename}.ContentID",
    );
    $Self->{MainObject}->FileDelete(
        Directory => $Directory,
        Filename  => "$File{Filename}.Disposition",
    );
    return 1;
}

sub FormIDGetAllFilesData {
    my ( $Self, %Param ) = @_;

    if ( !$Param{FormID} ) {
        $Self->{LogObject}->Log( Priority => 'error', Message => 'Need FormID!' );
        return;
    }

    my @Data;

    my $Directory = $Self->{TempDir} . '/' . $Param{FormID};
    if ( !-d $Directory ) {
        return \@Data;
    }

    my @List = $Self->{MainObject}->DirectoryRead(
        Directory => $Directory,
        Filter    => "*",
    );

    my $Counter = 0;
    for my $File (@List) {

        # ignore meta files
        next if $File =~ /\.ContentType$/;
        next if $File =~ /\.ContentID$/;
        next if $File =~ /\.Disposition$/;

        $Counter++;
        my $FileSize = -s $File;

        # human readable file size
        if (defined $FileSize) {

            # remove meta data in files
            if ( $FileSize > 30 ) {
                $FileSize = $FileSize - 30
            }
            if ( $FileSize > 1048576 ) {    # 1024 * 1024
                $FileSize = sprintf "%.1f MB", ( $FileSize / 1048576 );    # 1024 * 1024
            }
            elsif ( $FileSize > 1024 ) {
                $FileSize = sprintf "%.1f KB", ( ( $FileSize / 1024 ) );
            }
            else {
                $FileSize = $FileSize . ' B';
            }
        }
        my $Content = $Self->{MainObject}->FileRead(
            Location => $File,
            Mode     => 'binmode',    # optional - binmode|utf8
        );
        next if !$Content;

        my $ContentType = $Self->{MainObject}->FileRead(
            Location => "$File.ContentType",
            Mode     => 'binmode',             # optional - binmode|utf8
        );
        next if !$ContentType;

        my $ContentID = $Self->{MainObject}->FileRead(
            Location => "$File.ContentID",
            Mode     => 'binmode',             # optional - binmode|utf8
        );
        next if !$ContentID;

        # verify if content id is empty, set to undef
        if ( !${$ContentID} ) {
            ${$ContentID} = undef;
        }

        my $Disposition = $Self->{MainObject}->FileRead(
            Location => "$File.Disposition",
            Mode     => 'binmode',             # optional - binmode|utf8
        );
        next if !$Disposition;

        # strip filename
        $File =~ s/^.*\/(.+?)$/$1/;
        push(
            @Data,
            {
                Content     => ${$Content},
                ContentID   => ${$ContentID},
                ContentType => ${$ContentType},
                Filename    => $File,
                Filesize    => $FileSize,
                FileID      => $Counter,
                Disposition => ${$Disposition},
            },
        );
    }
    return \@Data;

}

sub FormIDGetAllFilesMeta {
    my ( $Self, %Param ) = @_;

    if ( !$Param{FormID} ) {
        $Self->{LogObject}->Log( Priority => 'error', Message => 'Need FormID!' );
        return;
    }

    my @Data;

    my $Directory = $Self->{TempDir} . '/' . $Param{FormID};
    if ( !-d $Directory ) {
        return \@Data;
    }

    my @List = $Self->{MainObject}->DirectoryRead(
        Directory => $Directory,
        Filter    => "*",
    );

    my $Counter = 0;
    for my $File (@List) {

        # ignore meta files
        next if $File =~ /\.ContentType$/;
        next if $File =~ /\.ContentID$/;
        next if $File =~ /\.Disposition$/;

        $Counter++;
        my $FileSize = -s $File;

        # human readable file size
        if (defined $FileSize) {

            # remove meta data in files
            if ( $FileSize > 30 ) {
                $FileSize = $FileSize - 30
            }
            if ( $FileSize > 1048576 ) {    # 1024 * 1024
                $FileSize = sprintf "%.1f MB", ( $FileSize / 1048576 );    # 1024 * 1024
            }
            elsif ( $FileSize > 1024 ) {
                $FileSize = sprintf "%.1f KB", ( ( $FileSize / 1024 ) );
            }
            else {
                $FileSize = $FileSize . ' B';
            }
        }

        my $ContentType = $Self->{MainObject}->FileRead(
            Location => "$File.ContentType",
            Mode     => 'binmode',             # optional - binmode|utf8
        );
        next if !$ContentType;

        my $ContentID = $Self->{MainObject}->FileRead(
            Location => "$File.ContentID",
            Mode     => 'binmode',             # optional - binmode|utf8
        );
        next if !$ContentID;

        # verify if content id is empty, set to undef
        if ( !${$ContentID} ) {
            ${$ContentID} = undef;
        }

        my $Disposition = $Self->{MainObject}->FileRead(
            Location => "$File.Disposition",
            Mode     => 'binmode',             # optional - binmode|utf8
        );
        next if !$Disposition;

        # strip filename
        $File =~ s/^.*\/(.+?)$/$1/;
        push(
            @Data,
            {
                ContentID   => ${$ContentID},
                ContentType => ${$ContentType},
                Filename    => $File,
                Filesize    => $FileSize,
                FileID      => $Counter,
                Disposition => ${$Disposition},
            },
        );
    }
    return \@Data;
}

sub FormIDCleanUp {
    my ( $Self, %Param ) = @_;

    my $RetentionTime = int(time() - 86400); # remove subdirs older than 24h
    my @List        = $Self->{MainObject}->DirectoryRead(
        Directory => $Self->{TempDir},
        Filter    => '*'
    );

    SUBDIR:
    for my $Subdir (@List) {
        my $SubdirTime = $Subdir;

        if ($SubdirTime =~ /^.*\/\d+\..+$/) {
            $SubdirTime =~ s/^.*\/(\d+?)\..+$/$1/
        }
        else {
            $Self->{LogObject}->Log(
                Priority => 'error',
                Message  => "Won't delete upload cache directory $Subdir: timestamp in directory name not found! Please fix it manually.",
            );
            next SUBDIR;
        }

        if ( $RetentionTime > $SubdirTime ) {
            my @Sublist = $Self->{MainObject}->DirectoryRead(
                Directory => $Subdir,
                Filter    => "*",
            );

            for my $File (@Sublist) {
                $Self->{MainObject}->FileDelete(
                    Location => $File,
                );
            }

            if ( !rmdir($Subdir) ) {
                $Self->{LogObject}->Log(
                    Priority => 'error',
                    Message  => "Can't remove: $Subdir: $!!",
                );
                return;
             }
         }
    }

    return 1;
}

1;
