# --
# Copyright (C) 2001-2018 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

use strict;
use warnings;
use utf8;

use vars (qw($Self));

my $Selenium = $Kernel::OM->Get('Kernel::System::UnitTest::Selenium');

$Selenium->RunTest(
    sub {

        my $Helper       = $Kernel::OM->Get('Kernel::System::UnitTest::Helper');
        my $ConfigObject = $Kernel::OM->Get('Kernel::Config');

        # Create test user.
        my $TestUserLogin = $Helper->TestUserCreate(
            Groups => ['admin'],
        ) || die "Did not get test user";

        # Get test user ID.
        my $TestUserID = $Kernel::OM->Get('Kernel::System::User')->UserLookup(
            UserLogin => $TestUserLogin,
        );

        # Login as test user.
        $Selenium->Login(
            Type     => 'Agent',
            User     => $TestUserLogin,
            Password => $TestUserLogin,
        );

        my $ScriptAlias = $ConfigObject->Get('ScriptAlias');
        my $Home        = $ConfigObject->Get('Home');

        # Navigate to AdminGenericInterfaceWebservice screen.
        $Selenium->VerifiedGet("${ScriptAlias}index.pl?Action=AdminGenericInterfaceWebservice");

        # Click 'Add web service' button.
        $Selenium->find_element("//button[\@type='submit']")->VerifiedClick();
        $Selenium->WaitFor( JavaScript => "return typeof(\$) === 'function' && \$('#Name').length" );

        # Check GenericInterface Web Service Management - Add screen.
        for my $ID (
            qw(Name Description RemoteSystem DebugThreshold ValidID ImportButton)
            )
        {
            my $Element = $Selenium->find_element( "#$ID", 'css' );
            $Element->is_enabled();
            $Element->is_displayed();
        }
        $Selenium->find_element( 'Cancel', 'link_text' )->VerifiedClick();

        # Set test values.
        my %Description = (
            webserviceconfig_1 => 'Connector to send and receive date from Nagios.',
            webserviceconfig_2 => 'Connector to send and receive date from Nagios 2.',
        );

        for my $Webservice (
            qw(webserviceconfig_1 webserviceconfig_2)
            )
        {

            # Click 'Add web service' button.
            $Selenium->find_element("//button[\@type='submit']")->VerifiedClick();
            $Selenium->WaitFor( JavaScript => "return typeof(\$) === 'function' && \$('#ImportButton').length" );

            # Import web service.
            $Selenium->find_element( "#ImportButton", 'css' )->click();
            $Selenium->WaitFor( JavaScript => "return typeof(\$) === 'function' && \$('.Dialog.Modal').length" );

            my $File     = $Webservice . '.yml';
            my $Location = "$Home/scripts/test/sample/Webservice/$File";
            $Selenium->find_element( "#ConfigFile",         'css' )->send_keys($Location);
            $Selenium->find_element( "#ImportButtonAction", 'css' )->click();
            $Selenium->WaitFor(
                JavaScript =>
                    "return typeof(\$) === 'function' && !\$('.Dialog.Modal').length && \$('tr td:contains(\"$Webservice\")').length"
            );

            # Verify that webservice is created.
            $Self->True(
                $Selenium->execute_script(
                    "return \$('.MessageBox p:contains(Web service \"$Webservice\" created)').length"
                ),
                "$Webservice is created",
            );

            # GenericInterface Web Service Management - Change screen.
            $Selenium->find_element( $Webservice, 'link_text' )->VerifiedClick();
            $Selenium->WaitFor(
                JavaScript =>
                    "return typeof(\$) === 'function' && \$('#ValidID').length && \$('#RemoteSystem').length"
            );
            $Selenium->execute_script("\$('#ValidID').val('2').trigger('redraw.InputField').trigger('change');");
            $Selenium->find_element( "#RemoteSystem", 'css' )->send_keys('Test remote system');

            # Save edited value.
            $Selenium->find_element( "#SaveAndFinishButton", 'css' )->VerifiedClick();
            $Selenium->WaitFor(
                JavaScript =>
                    "return typeof(\$) === 'function' && \$('tr.Invalid td:contains(\"$Webservice\")').length"
            );

            # Check class of invalid webservice in the overview table.
            $Self->True(
                $Selenium->execute_script(
                    "return \$('tr.Invalid td:contains($Webservice)').length"
                ),
                "There is a class 'Invalid' for test Webservice",
            );

            # Check web service values.
            $Selenium->find_element( $Webservice, 'link_text' )->VerifiedClick();

            $Self->Is(
                $Selenium->find_element( '#Name', 'css' )->get_value(),
                $Webservice,
                "#Name stored value",
            );

            $Self->Is(
                $Selenium->find_element( '#Description', 'css' )->get_value(),
                $Description{$Webservice},
                '#Description stored value',
            );

            $Self->Is(
                $Selenium->find_element( '#RemoteSystem', 'css' )->get_value(),
                'Test remote system',
                '#RemoteSystem updated value',
            );

            $Self->Is(
                $Selenium->find_element( '#ValidID', 'css' )->get_value(),
                2,
                "#ValidID updated value",
            );

            # Delete web service.
            $Selenium->find_element( "#DeleteButton", 'css' )->click();
            $Selenium->WaitFor(
                JavaScript =>
                    "return typeof(\$) === 'function' && \$('.Dialog.Modal').length && \$('#DialogButton2').length"
            );
            $Selenium->find_element( "#DialogButton2", 'css' )->click();

            # Wait until delete dialog has closed and action performed.
            $Selenium->WaitFor( JavaScript => "return typeof(\$) === 'function' && !\$('#DialogButton2').length" );
            $Selenium->WaitFor(
                JavaScript =>
                    'return typeof(Core) == "object" && typeof(Core.App) == "object" && Core.App.PageLoadComplete'
            );

            # Verify that webservice is deleted.
            $Self->True(
                index( $Selenium->get_page_source(), "Web service \"$Webservice\" deleted!" ) > -1,
                "$Webservice is deleted",
            );

        }
    }
);

1;
