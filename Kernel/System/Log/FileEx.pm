# --
# Kernel/System/Log/FileEx.pm - file log backend
# Copyright (C) 2001-2011 Informatyka Boguslawski sp. z o.o. sp.k., http://www.ib.pl/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::System::Log::FileEx;

use strict;
use warnings;

use vars qw($VERSION);
$VERSION = qw($Revision: 1.00 $) [1];

umask "002";

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {};
    bless( $Self, $Type );

    # get needed objects
    for (qw(ConfigObject EncodeObject)) {
        if ( $Param{$_} ) {
            $Self->{$_} = $Param{$_};
        }
        else {
            die "Got no $_!";
        }
    }

    # get logfile location
    $Self->{LogFile} = $Param{ConfigObject}->Get('LogModule::LogFile')
        || die 'Need LogModule::LogFile param in Config.pm';

    # get log file suffix
    if ( $Param{ConfigObject}->Get('LogModule::LogFile::Date') ) {
        my ( $s, $m, $h, $D, $M, $Y, $wd, $yd, $dst ) = localtime( time() );
        $Y = $Y + 1900;
        $M++;
        $Self->{LogFile} .= ".$Y-$M";
    }

    # Fixed bug# 2265 - For IIS we need to create a own error log file.
    # Bind stderr to log file, because iis do print stderr to web page.
    if ( $ENV{SERVER_SOFTWARE} && $ENV{SERVER_SOFTWARE} =~ /^microsoft\-iis/i ) {
        if ( !open STDERR, '>>', $Self->{LogFile} . '.error' ) {
            print STDERR "ERROR: Can't write $Self->{LogFile}.error: $!";
        }
    }

    return $Self;
}

sub Log {
    my ( $Self, %Param ) = @_;

    my $FH;

    # open logfile
    if ( !open $FH, '>>', $Self->{LogFile} ) {

        # print error screen
        print STDERR "\n";
        print STDERR " >> Can't write $Self->{LogFile}: $! <<\n";
        print STDERR "\n";
        return;
    }

    # write log file
    $Self->{EncodeObject}->SetIO($FH);
    print $FH localtime() . "\t";
    if ( lc $Param{Priority} eq 'debug' ) {
        print $FH "debug\t$Param{Module}($Param{Line})\t$Param{LogPrefix}\t$Param{Message}\n";
    }
    elsif ( lc $Param{Priority} eq 'info' ) {
        print $FH "info\t$Param{Module}\t$Param{LogPrefix}\t$Param{Message}\n";
    }
    elsif ( lc $Param{Priority} eq 'notice' ) {
        print $FH "notice\t$Param{Module}\t$Param{LogPrefix}\t$Param{Message}\n";
    }
    elsif ( lc $Param{Priority} eq 'error' ) {
        print $FH "error\t$Param{Module}($Param{Line})\t$Param{LogPrefix}\t$Param{Message}\n";
    }
    else {

        # print error messages to STDERR
        print STDERR
            "[Error][$Param{Module}] Priority: '$Param{Priority}' not defined! Message: $Param{Message}\n";

        # and of course to logfile
        print $FH
            "error\t$Param{Module}\t$Param{LogPrefix}\tPriority: '$Param{Priority}' not defined! Message: $Param{Message}\n";
    }

    # close file handle
    close $FH;
    return 1;
}

sub GetLog {
    my ( $Self, %Param ) = @_;

    # get needed params
    for (qw(Limit)) {
        if ( ! $Param{$_} ) {
            die "Got no $_!";
        }
    }

    # open logfile
    if ( !open FH, $Self->{LogFile} ) {

        # print error screen
        print STDERR "\n";
        print STDERR " >> Can't read $Self->{LogFile}: $! <<\n";
        print STDERR "\n";
        return;
    }

    # read log and close file
    my @lines = <FH>;
    close(FH);

    # get number of lines in log file
    my $lines_no = @lines;

    # return last Limit lines in reversed order
    my $String = '';
    for (my $i = $lines_no; (($i > 0) && ($lines_no - $i < $Param{Limit} )); $i--)
    {
       $String = $String . $lines[$i-1];
    }

    return $String;
}

1;
