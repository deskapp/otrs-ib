# --
# Copyright (C) 2001-2017 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::System::Console::Command::Maint::PostMaster::SpoolMailsReprocess;

use strict;
use warnings;

use base qw(Kernel::System::Console::BaseCommand);

our @ObjectDependencies = (
    'Kernel::Config',
    'Kernel::System::Log',
    'Kernel::System::Main',
);

sub Configure {
    my ( $Self, %Param ) = @_;

    $Self->Description('Reprocess mails from spool directory that could not be imported in the first place.');

    return;
}

sub PreRun {
    my ( $Self, %Param ) = @_;

    # get config object
    my $ConfigObject = $Kernel::OM->Get('Kernel::Config');

    my $MailReprocessSpoolDir = $ConfigObject->Get('MailReprocessSpoolDir')
        || $ConfigObject->Get('Home') . '/var/spool';
    if ( !-d $MailReprocessSpoolDir ) {
        die "Spool directory ${MailReprocessSpoolDir} does not exist!\n";
    }

    return;
}

sub Run {
    my ( $Self, %Param ) = @_;

    # get config object
    my $ConfigObject = $Kernel::OM->Get('Kernel::Config');

    my $Home = $ConfigObject->Get('Home');
    my $MailReprocessSpoolDir = $ConfigObject->Get('MailReprocessSpoolDir') || "$Home/var/spool";

    $Self->Print("<yellow>Processing mails in ${MailReprocessSpoolDir}...</yellow>\n");

    my @Files = $Kernel::OM->Get('Kernel::System::Main')->DirectoryRead(
        Directory => $MailReprocessSpoolDir,
        Filter    => '*',
    );

    my $Success = 1;

    for my $File (@Files) {
        $Self->Print("  Processing <yellow>$File</yellow>... ");

        # Here we use a system call because Maint::PostMaster::Read has special exception handling
        #   and will die if certain problems occur.
        my $Result = system("$^X $Home/bin/otrs.Console.pl Maint::PostMaster::Read <  $File ");

        # Exit code 0 == success
        if ( !$Result ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'info',
                Message  => "Successfully reprocessed email $File.",
            );
            unlink $File;
            $Self->Print("<green>Ok.</green>\n");
        }
        else {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Could not re-process email $File.",
            );
            $Self->Print("<red>Failed.</red>\n");
            $Success = 0;
        }
    }

    if ( !$Success ) {
        $Self->PrintError("There were problems importing the spool mails.");
        return $Self->ExitCodeError();
    }

    $Self->Print("<green>Done.</green>\n");
    return $Self->ExitCodeOk();
}

1;
