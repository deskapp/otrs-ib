# --
# Copyright (C) 2001-2018 OTRS AG, https://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (GPL). If you
# did not receive this file, see https://www.gnu.org/licenses/gpl-3.0.txt.
# --

use strict;
use warnings;
use utf8;

use vars (qw($Self));

my $Selenium = $Kernel::OM->Get('Kernel::System::UnitTest::Selenium');

$Selenium->RunTest(
    sub {

        my $Helper = $Kernel::OM->Get('Kernel::System::UnitTest::Helper');

        # Make sure we start with RuntimeDB search.
        $Helper->ConfigSettingChange(
            Valid => 1,
            Key   => 'Ticket::SearchIndexModule',
            Value => 'Kernel::System::Ticket::ArticleSearchIndex::RuntimeDB',
        );

        my $TestUserLogin = $Helper->TestUserCreate(
            Groups => [ 'admin', 'users' ],
        ) || die "Did not get test user";

        $Selenium->Login(
            Type     => 'Agent',
            User     => $TestUserLogin,
            Password => $TestUserLogin,
        );

        my $RandomID = $Helper->GetRandomID();

        my $DynamicFieldObject = $Kernel::OM->Get('Kernel::System::DynamicField');
        my $DFTextName         = 'Text' . $RandomID;

        my %DynamicFields = (
            Date => {
                Name       => 'TestDate' . $RandomID,
                Label      => 'TestDate' . $RandomID,
                FieldOrder => 9990,
                FieldType  => 'Date',
                ObjectType => 'Ticket',
                Config     => {
                    DefaultValue  => 0,
                    YearsInFuture => 0,
                    YearsInPast   => 50,
                    YearsPeriod   => 1,
                },
                Reorder => 1,
                ValidID => 1,
                UserID  => 1,
            },
            DateTime => {
                Name       => 'TestDateTime' . $RandomID,
                Label      => 'TestDateTime' . $RandomID,
                FieldOrder => 9990,
                FieldType  => 'DateTime',
                ObjectType => 'Ticket',
                Config     => {
                    DefaultValue  => 0,
                    YearsInFuture => 0,
                    YearsInPast   => 50,
                    YearsPeriod   => 1,
                },
                Reorder => 1,
                ValidID => 1,
                UserID  => 1,
            },
            Text => {
                Name       => $DFTextName,
                Label      => $DFTextName,
                FieldOrder => 9990,
                FieldType  => 'Text',
                ObjectType => 'Ticket',
                Config     => {
                    DefaultValue => '',
                },
                Reorder => 1,
                ValidID => 1,
                UserID  => 1,
            },
        );

        my @DynamicFieldIDs;

        # Create test dynamic field of type date
        for my $DynamicFieldType ( sort keys %DynamicFields ) {

            my $DynamicFieldID = $DynamicFieldObject->DynamicFieldAdd(
                %{ $DynamicFields{$DynamicFieldType} },
            );

            $Self->True(
                $DynamicFieldID,
                "Dynamic field $DynamicFields{$DynamicFieldType}->{Name} - ID $DynamicFieldID - created",
            );

            push @DynamicFieldIDs, $DynamicFieldID;
        }

        my %LookupDynamicFieldNames = map { $DynamicFields{$_}->{Name} => 1 } sort keys %DynamicFields;

        $Helper->ConfigSettingChange(
            Valid => 1,
            Key   => 'Ticket::Frontend::AgentTicketSearch###DynamicField',
            Value => \%LookupDynamicFieldNames,
        );

        # Make sure test ticket create time is known since we will be search by it.
        $Helper->FixedTimeSet(
            $Kernel::OM->Get('Kernel::System::Time')->TimeStamp2SystemTime( String => '2017-05-04 23:00:00' )
        );

        my $TicketObject = $Kernel::OM->Get('Kernel::System::Ticket');

        my @TicketIDs;
        my $TitleRandom  = "Title" . $RandomID;
        my $TicketNumber = $TicketObject->TicketCreateNumber();
        my $TicketID     = $TicketObject->TicketCreate(
            TN         => $TicketNumber,
            Title      => $TitleRandom,
            Queue      => 'Raw',
            Lock       => 'unlock',
            Priority   => '3 normal',
            State      => 'open',
            CustomerID => 'SeleniumCustomer',
            OwnerID    => 1,
            UserID     => 1,
        );
        $Self->True(
            $TicketID,
            "Ticket is created - ID $TicketID",
        );
        push @TicketIDs, $TicketID;

        my $MinCharString = 'ct';
        my $MaxCharString = $RandomID . ( 't' x 50 );
        my $Subject       = 'SubjectTitle' . $RandomID;
        my $ArticleID     = $TicketObject->ArticleCreate(
            TicketID    => $TicketID,
            ArticleType => 'note-internal',
            SenderType  => 'agent',
            Subject     => $Subject,
            Body =>
                "'maybe $MinCharString in an abbreviation' this is string with more than 30 characters $MaxCharString",
            ContentType    => 'text/plain; charset=ISO-8859-15',
            HistoryType    => 'OwnerUpdate',
            HistoryComment => 'Some free text!',
            UserID         => 1,
            NoAgentNotify  => 1,
        );
        $Self->True(
            $ArticleID,
            "Article is created - ID $ArticleID",
        );

        my $ScriptAlias = $Kernel::OM->Get('Kernel::Config')->Get('ScriptAlias');

        $Selenium->VerifiedGet("${ScriptAlias}index.pl?Action=AgentTicketSearch");

        # Wait until form and overlay has loaded, if neccessary.
        $Selenium->WaitFor( JavaScript => "return typeof(\$) === 'function' && \$('#SearchProfile').length" );

        # Check the general fields for ticket search page.
        for my $ID (
            qw(SearchProfile SearchProfileNew Attribute ResultForm SearchFormSubmit)
            )
        {
            my $Element = $Selenium->find_element( "#$ID", 'css' );
            $Element->is_enabled();
            $Element->is_displayed();
        }

        # Add search filter by ticket number and run it.
        $Selenium->find_element( '.AddButton',        'css' )->click();
        $Selenium->find_element( 'TicketNumber',      'name' )->send_keys($TicketNumber);
        $Selenium->find_element( '#SearchFormSubmit', 'css' )->VerifiedClick();

        # Check for expected result.
        $Self->True(
            index( $Selenium->get_page_source(), $TitleRandom ) > -1,
            "Ticket $TitleRandom found on page",
        );

        $Selenium->VerifiedGet("${ScriptAlias}index.pl?Action=AgentTicketSearch");

        # Wait until form and overlay has loaded, if neccessary.
        $Selenium->WaitFor( JavaScript => "return typeof(\$) === 'function' && \$('#SearchProfile').length" );

        # Input wrong search parameters, result should be 'No ticket data found'.
        $Selenium->find_element( "Fulltext",          'name' )->send_keys('abcdfgh_nonexisting_ticket_text');
        $Selenium->find_element( '#SearchFormSubmit', 'css' )->VerifiedClick();

        $Self->True(
            index( $Selenium->get_page_source(), "No ticket data found." ) > -1,
            "Ticket is not found on page",
        );

        $Selenium->VerifiedGet("${ScriptAlias}index.pl?Action=AgentTicketSearch");

        # Wait until form and overlay has loaded, if neccessary.
        $Selenium->WaitFor( JavaScript => "return typeof(\$) === 'function' && \$('#SearchProfile').length" );

        # Search for $MaxCharString with RuntimeDB - ticket must be found.
        $Selenium->find_element( "Fulltext",          'name' )->send_keys($MaxCharString);
        $Selenium->find_element( '#SearchFormSubmit', 'css' )->click();

        $Self->True(
            index( $Selenium->get_page_source(), $TitleRandom ) > -1,
            "Ticket $TitleRandom found on page with RuntimeDB search with string longer then 30 characters",
        );

        # Change search index module.
        $Helper->ConfigSettingChange(
            Valid => 1,
            Key   => 'Ticket::SearchIndexModule',
            Value => 'Kernel::System::Ticket::ArticleSearchIndex::StaticDB',
        );

        # Enable warn on stop word usage.
        $Helper->ConfigSettingChange(
            Valid => 1,
            Key   => 'Ticket::SearchIndex::WarnOnStopWordUsage',
            Value => 1,
        );

        # Recreate TicketObject and update article index for staticdb.
        $Kernel::OM->ObjectsDiscard( Objects => ['Kernel::System::Ticket'] );
        $TicketObject = $Kernel::OM->Get('Kernel::System::Ticket');
        $TicketObject->ArticleIndexBuild(
            ArticleID => $ArticleID,
            UserID    => 1,
        );

        # Navigate to AgentTicketSearch screen again.
        $Selenium->VerifiedGet("${ScriptAlias}index.pl?Action=AgentTicketSearch");

        # Wait until form and overlay has loaded, if neccessary.
        $Selenium->WaitFor( JavaScript => "return typeof(\$) === 'function' && \$('#SearchProfile').length" );

        # Try to search fulltext with string less then 3 characters.
        $Selenium->find_element( "Fulltext",          'name' )->send_keys($MinCharString);
        $Selenium->find_element( '#SearchFormSubmit', 'css' )->click();

        $Selenium->WaitFor( AlertPresent => 1 ) || die 'Alert for MinCharString not found';

        # Verify the alert message.
        my $ExpectedAlertText = "Fulltext: $MinCharString";
        $Self->True(
            $Selenium->get_alert_text() =~ /$ExpectedAlertText/,
            'Minimum character string search warning is found',
        );

        # Accept the alert to continue with the tests.
        $Selenium->accept_alert();

        # Try to search fulltext with string more than 30 characters.
        $Selenium->find_element( "Fulltext",          'name' )->clear();
        $Selenium->find_element( "Fulltext",          'name' )->send_keys($MaxCharString);
        $Selenium->find_element( '#SearchFormSubmit', 'css' )->click();

        $Selenium->WaitFor( AlertPresent => 1 ) || die 'Alert for MaxCharString not found';

        # Verify the alert message.
        $ExpectedAlertText = "Fulltext: $MaxCharString";
        $Self->True(
            $Selenium->get_alert_text() =~ /$ExpectedAlertText/,
            'Maximum character string search warning is found',
        );

        # Accept the alert to continue with the tests.
        $Selenium->accept_alert();

        # Try to search fulltext with 'stop word' search.
        $Selenium->find_element( "Fulltext",          'name' )->clear();
        $Selenium->find_element( "Fulltext",          'name' )->send_keys('because');
        $Selenium->find_element( '#SearchFormSubmit', 'css' )->click();

        $Selenium->WaitFor( AlertPresent => 1 ) || die 'Alert for stop word not found';

        # Verify the alert message.
        $ExpectedAlertText = "Fulltext: because";
        $Self->True(
            $Selenium->get_alert_text() =~ /$ExpectedAlertText/,
            'Stop word search string warning is found',
        );

        # Accept the alert to continue with the tests.
        $Selenium->accept_alert();

        # Search fulltext with correct input.
        $Selenium->find_element( "Fulltext", 'name' )->clear();
        $Selenium->find_element( "Fulltext", 'name' )->send_keys($Subject);
        $Selenium->find_element("//button[\@id='SearchFormSubmit']")->VerifiedClick();

        $Selenium->WaitFor( JavaScript => "return typeof(\$) === 'function' && \$('div.TicketZoom').length" );

        # Check for expected result.
        $Self->True(
            index( $Selenium->get_page_source(), $TitleRandom ) > -1,
            "Ticket $TitleRandom found on page with correct StaticDB search",
        );

        # Navigate to AgentTicketSearch screen again.
        $Selenium->VerifiedGet("${ScriptAlias}index.pl?Action=AgentTicketSearch");

        # Wait until form and overlay has loaded, if neccessary.
        $Selenium->WaitFor( JavaScript => "return typeof(\$) === 'function' && \$('#SearchProfile').length" );

        # Add search filter by ticket create time and set it to invalid date (April 31st).
        $Selenium->execute_script(
            "\$('#Attribute').val('TicketCreateTimeSlot').trigger('redraw.InputField').trigger('change');",
        );

        $Selenium->find_element( '.AddButton',                                      'css' )->click();
        $Selenium->find_element( '#TicketCreateTimeStartDay option[value="31"]',    'css' )->click();
        $Selenium->find_element( '#TicketCreateTimeStartMonth option[value="4"]',   'css' )->click();
        $Selenium->find_element( '#TicketCreateTimeStartYear option[value="2017"]', 'css' )->click();

        $Selenium->find_element( '#SearchFormSubmit', 'css' )->click();
        $Selenium->WaitFor(
            JavaScript => "return typeof(\$) === 'function' && \$('#TicketCreateTimeStartDay.Error').length"
        );

        $Self->True(
            $Selenium->execute_script(
                "return \$('#TicketCreateTimeStartDay.Error').length;"
            ),
            'Invalid date highlighted as an error'
        );

        $Selenium->find_element( '#TicketCreateTimeStartDay option[value="4"]',    'css' )->click();
        $Selenium->find_element( '#TicketCreateTimeStartMonth option[value="5"]',  'css' )->click();
        $Selenium->find_element( '#TicketCreateTimeStopDay option[value="4"]',     'css' )->click();
        $Selenium->find_element( '#TicketCreateTimeStopMonth option[value="5"]',   'css' )->click();
        $Selenium->find_element( '#TicketCreateTimeStopYear option[value="2017"]', 'css' )->click();
        $Selenium->find_element( '#SearchFormSubmit',                              'css' )->VerifiedClick();

        # Check for expected result.
        $Self->True(
            index( $Selenium->get_page_source(), $TitleRandom ) > -1,
            "Ticket $TitleRandom found on page"
        );

        # Navigate to AgentTicketSearch screen again.
        $Selenium->VerifiedGet("${ScriptAlias}index.pl?Action=AgentTicketSearch");

        # Wait until form and overlay has loaded, if necessary.
        $Selenium->WaitFor( JavaScript => "return typeof(\$) === 'function' && \$('#SearchProfile').length" );

        # Add search filter by priority and run it.
        $Selenium->execute_script(
            "\$('#Attribute').val('PriorityIDs').trigger('redraw.InputField').trigger('change');",
        );
        $Selenium->find_element( '.AddButton',          'css' )->click();
        $Selenium->find_element( '#PriorityIDs_Search', 'css' )->click();

        # Wait until drop down list is shown.
        $Selenium->WaitFor(
            JavaScript => "return typeof(\$) === 'function' && \$('.InputField_ListContainer').length"
        );

        # Click on remove button next to priority field.
        $Selenium->find_element( '#PriorityIDs + .RemoveButton', 'css' )->click();

        # Wait until drop down list is hidden.
        $Selenium->WaitFor(
            JavaScript => "return typeof(\$) === 'function' && \$('.InputField_ListContainer').length == 0"
        );

        # Verify dropdown list has been hidden (bug#12243).
        $Self->True(
            index( $Selenium->get_page_source(), 'InputField_ListContainer' ) == -1,
            "InputField list not found on page",
        );

        for my $DynamicFieldType (qw(Date DateTime)) {

            # Add the date dynamic field, to check if the correct years are selectable (bug#12678).
            $Selenium->execute_script(
                "\$('#Attribute').val('Search_DynamicField_$DynamicFields{$DynamicFieldType}->{Name}TimeSlot').trigger('redraw.InputField').trigger('change');",
            );
            $Selenium->find_element( '.AddButton', 'css' )->click();

            for my $DatePart (qw(StartYear StartMonth StartDay StopYear StopMonth StopDay)) {
                my $Element = $Selenium->find_element(
                    "#Search_DynamicField_$DynamicFields{$DynamicFieldType}->{Name}TimeSlot$DatePart", 'css'
                );
                $Element->is_enabled();
                $Element->is_displayed();
            }

            # Check if the correct count of options in the year dropdown exists.
            for my $DatePart (qw(StartYear StopYear)) {
                $Self->Is(
                    $Selenium->execute_script(
                        "return \$('#Search_DynamicField_$DynamicFields{$DynamicFieldType}->{Name}TimeSlot$DatePart:visible > option').length;"
                    ),
                    51,
                    "DynamicField date $DatePart filtered options count",
                );
            }
        }

        # Test for dynamic field text type search with '||' (see bug#12560).
        # Create two tickets and set two different DF values for them.
        my $TextTypeDynamicFieldConfig = $DynamicFieldObject->DynamicFieldGet(
            Name => $DFTextName,
        );
        my $BackendObject = $Kernel::OM->Get('Kernel::System::DynamicField::Backend');
        my $Success;
        for my $DFValue (qw(GASZ JLEB)) {
            my $Title    = "Title$DFValue" . $RandomID;
            my $Number   = $TicketObject->TicketCreateNumber();
            my $TicketID = $TicketObject->TicketCreate(
                TN         => $Number,
                Title      => $Title,
                Queue      => 'Junk',
                Lock       => 'unlock',
                Priority   => ( $DFValue eq 'GASZ' ) ? '1 very low' : '2 low',
                State      => 'open',
                CustomerID => 'SeleniumCustomer',
                OwnerID    => 1,
                UserID     => 1,
            );
            $Self->True(
                $TicketID,
                "Ticket is created - ID $TicketID",
            );
            push @TicketIDs, $TicketID;

            $Success = $BackendObject->ValueSet(
                DynamicFieldConfig => $TextTypeDynamicFieldConfig,
                ObjectID           => $TicketID,
                Value              => $DFValue,
                UserID             => 1,
            );
            $Self->True(
                $Success,
                "Value '$DFValue' is set successfully for ticketID $TicketID",
            );
        }

        # Navigate to AgentTicketSearch screen.
        $Selenium->VerifiedGet("${ScriptAlias}index.pl?Action=AgentTicketSearch");

        # Wait until form and overlay has loaded, if necessary.
        $Selenium->WaitFor( JavaScript => "return typeof(\$) === 'function' && \$('#SearchProfile').length" );

        my $TextFieldID = 'Search_DynamicField_' . $DynamicFields{Text}->{Name};

        # Add search filter by text dynamic field and run it.
        $Selenium->execute_script(
            "\$('#Attribute').val('$TextFieldID').trigger('redraw.InputField').trigger('change');",
        );
        $Selenium->find_element( '.AddButton', 'css' )->click();
        $Selenium->WaitFor(
            JavaScript => "return typeof(\$) === 'function' && \$('#SearchInsert #$TextFieldID').length"
        );
        $Selenium->find_element( '#' . $TextFieldID,  'css' )->clear();
        $Selenium->find_element( '#' . $TextFieldID,  'css' )->send_keys('GASZ||JLEB');
        $Selenium->find_element( '#SearchFormSubmit', 'css' )->VerifiedClick();

        # Check if the last two created tickets are in the table.
        $Self->True(
            $Selenium->execute_script("return \$('#OverviewBody tbody tr[id=TicketID_$TicketIDs[1]').length;"),
            "TicketID $TicketIDs[1] is found in the table"
        );
        $Self->True(
            $Selenium->execute_script("return \$('#OverviewBody tbody tr[id=TicketID_$TicketIDs[2]').length;"),
            "TicketID $TicketIDs[2] is found in the table"
        );

        # Test searching by URL (see bug#7988).
        # Search for tickets in Junk queue and with DF values 'GASZ' or 'JLEB' -
        # the last two created tickets should be in the table.
        $Selenium->VerifiedGet(
            "${ScriptAlias}index.pl?Action=AgentTicketSearch;Subaction=Search;$TextFieldID=GASZ||JLEB;ShownAttributes=Label$TextFieldID"
        );
        $Self->True(
            $Selenium->execute_script("return \$('#OverviewBody tbody tr[id=TicketID_$TicketIDs[0]').length == 0"),
            "TicketID $TicketIDs[0] is not found in the table"
        );
        $Self->True(
            $Selenium->execute_script("return \$('#OverviewBody tbody tr[id=TicketID_$TicketIDs[1]').length"),
            "TicketID $TicketIDs[1] is found in the table"
        );
        $Self->True(
            $Selenium->execute_script("return \$('#OverviewBody tbody tr[id=TicketID_$TicketIDs[2]').length"),
            "TicketID $TicketIDs[2] is found in the table"
        );

        # Search for tickets with priorites '1 very low' and '2 low' -
        # the last two created tickets should be in the table.
        $Selenium->VerifiedGet(
            "${ScriptAlias}index.pl?Action=AgentTicketSearch;Subaction=Search;Priorities=1 very low;Priorities=2 low"
        );
        $Self->True(
            $Selenium->execute_script("return \$('#OverviewBody tbody tr[id=TicketID_$TicketIDs[0]').length == 0"),
            "TicketID $TicketIDs[0] is not found in the table"
        );
        $Self->True(
            $Selenium->execute_script("return \$('#OverviewBody tbody tr[id=TicketID_$TicketIDs[1]').length"),
            "TicketID $TicketIDs[1] is found in the table"
        );
        $Self->True(
            $Selenium->execute_script("return \$('#OverviewBody tbody tr[id=TicketID_$TicketIDs[2]').length"),
            "TicketID $TicketIDs[2] is found in the table"
        );

        # Clean up test data from the DB.
        for my $TicketID (@TicketIDs) {
            $Success = $TicketObject->TicketDelete(
                TicketID => $TicketID,
                UserID   => 1,
            );
            $Self->True(
                $Success,
                "Ticket $TicketID deleted",
            );
        }

        # Delete created test dynamic fields.
        for my $DynamicFieldID (@DynamicFieldIDs) {
            $Success = $DynamicFieldObject->DynamicFieldDelete(
                ID     => $DynamicFieldID,
                UserID => 1,
            );
            $Self->True(
                $Success,
                "Dynamic field - ID $DynamicFieldID - deleted",
            );
        }

        # make sure the cache is correct
        $Kernel::OM->Get('Kernel::System::Cache')->CleanUp( Type => 'Ticket' );

    },
);

1;
