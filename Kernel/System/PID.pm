# --
# Kernel/System/PID.pm - all system pid functions
# Copyright (C) 2001-2014 OTRS AG, http://otrs.com/
# Copyright (C) 2014 Informatyka Boguslawski sp. z o.o. sp.k., http://www.ib.pl/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::System::PID;

use strict;
use warnings;

=head1 NAME

Kernel::System::PID - to manage PIDs

=head1 SYNOPSIS

All functions to manage process ids

=head1 PUBLIC INTERFACE

=over 4

=cut

=item new()

create an object

    use Kernel::Config;
    use Kernel::System::Encode;
    use Kernel::System::Log;
    use Kernel::System::Main;
    use Kernel::System::DB;
    use Kernel::System::PID;

    my $ConfigObject = Kernel::Config->new();
    my $EncodeObject = Kernel::System::Encode->new(
        ConfigObject => $ConfigObject,
    );
    my $LogObject = Kernel::System::Log->new(
        ConfigObject => $ConfigObject,
        EncodeObject => $EncodeObject,
    );
    my $MainObject = Kernel::System::Main->new(
        ConfigObject => $ConfigObject,
        EncodeObject => $EncodeObject,
        LogObject    => $LogObject,
    );
    my $DBObject = Kernel::System::DB->new(
        ConfigObject => $ConfigObject,
        EncodeObject => $EncodeObject,
        LogObject    => $LogObject,
        MainObject   => $MainObject,
    );
    my $PIDObject = Kernel::System::PID->new(
        LogObject    => $LogObject,
        ConfigObject => $ConfigObject,
        DBObject     => $DBObject,
    );

=cut

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {};
    bless( $Self, $Type );

    # check needed objects
    for (qw(DBObject ConfigObject LogObject TimeObject)) {
        $Self->{$_} = $Param{$_} || die "Got no $_!";
    }

    # get common config options
    $Self->{Host} = $Self->{ConfigObject}->Get('FQDN');

    # save own PID
    $Self->{PID} = $$;

    return $Self;
}

=item PIDCreate()

create a new process id lock

    $PIDObject->PIDCreate(
        Name => 'PostMasterPOP3',
        Quiet => 0,  # 1=don't print anything, 0=notices printing enabled
    );

    or to create a new PID forced, without check if already exists

    $PIDObject->PIDCreate(
        Name  => 'PostMasterPOP3',
        Force => 1,
    );

    or to create a new PID with extra TTL time

    $PIDObject->PIDCreate(
        Name  => 'PostMasterPOP3',
        TTL   => 60 * 60 * 24 * 3, # for 3 days, per default 1h is used
    );

=cut

sub PIDCreate {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    if ( !$Param{Name} ) {
        $Self->{LogObject}->Log( Priority => 'error', Message => 'Need Name' );
        return;
    }

    my $Message;
    my %Data;
    my $CTime;
    my $MTime;
    my $Quiet;

    $Quiet = 1 if $Param{Quiet};

    # remove stalled PIDs

    # by default PIDs are consireded stalled after 1h; may be changed with TTL param
    my $TTL = $Param{TTL} || 3600;
    my $StalledThreshold = time() - $TTL;

    # get stalled pid list
    return if !$Self->{DBObject}->Prepare(
        SQL => 'SELECT process_host, process_name, process_id, process_create, process_change'
            . ' FROM process_id WHERE process_name = ? AND process_change < ?',
            Bind  => [ \$Param{Name}, \$StalledThreshold ],
        );

    # fetch the result and remove stalled pids
    while ( my @Row = $Self->{DBObject}->FetchrowArray() ) {
        %Data = (
            Host    => $Row[0],
            Name    => $Row[1],
            PID     => $Row[2],
            Created => $Row[3],
            Changed => $Row[4],
        );

        return if !$Self->PIDDelete(
            Host => $Data{Host},
            Name => $Data{Name},
            PID  => $Data{PID},
        );

        $CTime = $Self->{TimeObject}->SystemTime2TimeStamp( SystemTime => $Data{Created} );
        $MTime = $Self->{TimeObject}->SystemTime2TimeStamp( SystemTime => $Data{Changed} );

        $Message = "Stalled PID removed"
                . " (host: $Data{Host}, name: $Data{Name}, pid: $Data{PID}, created: $CTime, changed: $MTime, ttl: $TTL s)";

        $Self->{LogObject}->Log(
            Priority => 'notice',
            Message  => $Message,
        );

        if (!$Quiet) {
            print "NOTICE: $Message\n";
        }
    }

    # quit if not in forced mode and already running on any host
    %Data = $Self->PIDGetAny(%Param);
    if ( %Data ) {

        $CTime = $Self->{TimeObject}->SystemTime2TimeStamp( SystemTime => $Data{Created} );
        $MTime = $Self->{TimeObject}->SystemTime2TimeStamp( SystemTime => $Data{Changed} );

        if (!$Param{Force}) {

            $Message = "Other $Data{Name} process already running"
                    . " (host: $Data{Host}, name: $Data{Name}, pid: $Data{PID}, created: $CTime, changed: $MTime, ttl: $TTL s)."
                    . " No new $Data{Name} process will be started.";

            $Self->{LogObject}->Log(
                Priority => 'notice',
                Message  => $Message,
            );

            if (!$Quiet) {
                print "NOTICE: $Message\n";
            }

            return;

        } else {

            $Message = "Other $Data{Name} process already running"
                    . " (host: $Data{Host}, name: $Data{Name}, pid: $Data{PID}, created: $CTime, changed: $MTime, ttl: $TTL s)."
                    . " New $Data{Name} process start forced.";

            $Self->{LogObject}->Log(
                Priority => 'notice',
                Message  => $Message,
            );

            if (!$Quiet) {
                print "NOTICE: $Message\n";
            }

        }
    }

    # add new entry
    my $Time = time();
    return if !$Self->{DBObject}->Do(
        SQL => 'INSERT INTO process_id'
            . ' (process_host, process_name, process_id, process_create, process_change)'
            . ' VALUES (?, ?, ?, ?, ?)',
        Bind => [ \$Self->{Host}, \$Param{Name}, \$Self->{PID}, \$Time, \$Time ],
    );

    return 1;
}

=item PIDGet()

get process id with given name lock info

    my %PID = $PIDObject->PIDGet(
        Host => 'host1.localdomain',  # optional; own hostname if undefined
        Name => 'PostMasterPOP3',
        PID  => 3243,                 # optional; own PID if undefined
    );

=cut

sub PIDGet {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    if ( !$Param{Name} ) {
        $Self->{LogObject}->Log( Priority => 'error', Message => 'Need Name' );
        return;
    }

    my $Host = $Param{Host} || $Self->{Host};
    my $PID = $Param{PID} || $Self->{PID};

    # sql
    return if !$Self->{DBObject}->Prepare(
        SQL => 'SELECT process_host, process_name, process_id, process_create, process_change'
            . ' FROM process_id WHERE process_host = ? AND process_name = ? AND process_id = ?',
        Bind  => [ \$Host, \$Param{Name}, \$PID ],
        Limit => 1,
    );

    # fetch the result
    my %Data;
    while ( my @Row = $Self->{DBObject}->FetchrowArray() ) {
        %Data = (
            Host    => $Row[0],
            Name    => $Row[1],
            PID     => $Row[2],
            Created => $Row[3],
            Changed => $Row[4],
        );
    }

    return %Data;
}

=item PIDGetAny()

get process id from any host with given name lock info

    my %PID = $PIDObject->PIDGetAll(
        Name => 'PostMasterPOP3',
    );

=cut

sub PIDGetAny {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    if ( !$Param{Name} ) {
        $Self->{LogObject}->Log( Priority => 'error', Message => 'Need Name' );
        return;
    }

    # sql
    return if !$Self->{DBObject}->Prepare(
        SQL => 'SELECT process_host, process_name, process_id, process_create, process_change'
            . ' FROM process_id WHERE process_name = ?',
        Bind  => [ \$Param{Name} ],
        Limit => 1,
    );

    # fetch the result
    my %Data;
    while ( my @Row = $Self->{DBObject}->FetchrowArray() ) {
        %Data = (
            Host    => $Row[0],
            Name    => $Row[1],
            PID     => $Row[2],
            Created => $Row[3],
            Changed => $Row[4],
        );
    }

    return %Data;
}


=item PIDDelete()

delete the process id lock

    my $Success = $PIDObject->PIDDelete(
        Host => 'host1.localdomain',  # optional; own hostname if undefined
        Name => 'PostMasterPOP3',
        PID  => 3243,                 # optional; own PID if undefined
    );

    or to force delete even if the PID is registered by another host
    my $Success = $PIDObject->PIDDelete(
        Name  => 'PostMasterPOP3',
        Force => 1,
    );

=cut

sub PIDDelete {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    if ( !$Param{Name} ) {
        $Self->{LogObject}->Log( Priority => 'error', Message => 'Need Name' );
        return;
    }

    my $Host = $Param{Host} || $Self->{Host};
    my $PID = $Param{PID} || $Self->{PID};

    # set basic SQL statement
    my $SQL = 'DELETE FROM process_id WHERE process_name = ?';

    my @Bind = ( \$Param{Name} );

    # delete all processes with given name if Force was set
    if ( !$Param{Force} ) {
        $SQL .= ' AND process_host = ? AND process_id = ?';
        push @Bind, \$Host;
        push @Bind, \$PID;
    }

    # sql
    return if !$Self->{DBObject}->Do(
        SQL  => $SQL,
        Bind => \@Bind,
    );

    return 1;
}

=item PIDUpdate()

update the process id change time.
this might be useful as a keep alive signal.

    my $Success = $PIDObject->PIDUpdate(
        Host => 'host1.localdomain',  # optional; own hostname if undefined
        Name => 'PostMasterPOP3',
        PID  => 3243,                 # optional; own PID if undefined
    );

=cut

sub PIDUpdate {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    if ( !$Param{Name} ) {
        $Self->{LogObject}->Log( Priority => 'error', Message => 'Need Name' );
        return;
    }

    my %PID = $Self->PIDGet( Name => $Param{Name} );

    if ( !%PID ) {
        $Self->{LogObject}->Log( Priority => 'error', Message => 'No PID to update found' );
        return;
    }

    my $Host = $Param{Host} || $Self->{Host};
    my $PID = $Param{PID} || $Self->{PID};

    # sql
    my $Time = time();
    return if !$Self->{DBObject}->Do(
        SQL => 'UPDATE process_id SET process_change = ?'
            . ' WHERE process_host = ? AND process_name = ? AND process_id = ?',
        Bind => [ \$Time, \$Host, \$Param{Name}, \$PID ],
    );

    return 1;
}

1;

=back

=head1 TERMS AND CONDITIONS

This software is part of the OTRS project (L<http://otrs.org/>).

This software comes with ABSOLUTELY NO WARRANTY. For details, see
the enclosed file COPYING for license information (AGPL). If you
did not receive this file, see L<http://www.gnu.org/licenses/agpl.txt>.

=cut
