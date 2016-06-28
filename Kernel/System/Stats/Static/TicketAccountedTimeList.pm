# --
# Module for accounted time reporting
# Copyright (C) 2015-2016 Informatyka Boguslawski sp. z o.o. sp.k., http://www.ib.pl/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::System::Stats::Static::TicketAccountedTimeList;

use strict;
use warnings;

our @ObjectDependencies = (
    'Kernel::Language',
    'Kernel::System::DB',
    'Kernel::System::Queue',
    'Kernel::System::Service',
    'Kernel::System::SLA',
    'Kernel::System::State',
    'Kernel::System::Time',
    'Kernel::System::CustomerUser',
);

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {};
    bless( $Self, $Type );

    return $Self;
}

sub Param {
    my $Self = shift;

    # get language object
    my $LanguageObject = $Kernel::OM->Get('Kernel::Language');

    # get time object
    my $TimeObject = $Kernel::OM->Get('Kernel::System::Time');

    # get current time
    my ($s,$m,$h, $D,$M,$Y) = $TimeObject->SystemTime2Date(
        SystemTime => $TimeObject->SystemTime(),
    );

    # period limit
    my $FirstYearMonth = ( 2010 * 100 ) + 1;

    # one month before as default selection
    my $SelectedYear = $M == 1 ? $Y - 1 : $Y;
    my $SelectedMonth = $M == 1 ? 12 : $M;
    my $SelectedYearMonth = ( $SelectedYear * 100 ) + $SelectedMonth;

    my %YearMonth = ();

    for (my $Year = $Y - 10; $Year <= $Y; $Year++)
    {
        for( my $Month = 1; ( $Month < 13 ) && ( $Year*100 + $Month <= $Y*100 + $M ) ; $Month++ )
        {
                if ( ( $Year*100 ) + $Month >= $FirstYearMonth )
            {
                $YearMonth{ ( $Year*100 ) + $Month } = sprintf( "%04d-%02d", $Year, $Month) ;
            }
        }
    }

    my %QueueList = $Kernel::OM->Get('Kernel::System::Queue')->QueueList(
        Valid => 1,
    );

    my %CustomerIDs = map {$_, $_} $Kernel::OM->Get('Kernel::System::CustomerUser')->CustomerIDList(
        Valid => 1,
    );

    my %UserList = $Kernel::OM->Get('Kernel::System::User')->UserList(
        Type => 'Short',
        Valid => 1,
    );

    my %StateList = $Kernel::OM->Get('Kernel::System::State')->StateList(
        UserID => 1,
        Valid  => 1,
    );

    my @Params = (
        {
            Frontend => 'States',
            Name => 'States',
            Multiple => 1,
            Size => 10,
            Data => {
                %StateList,
            },
        },
        {
            Frontend => 'Queues',
            Name => 'Queues',
            Multiple => 1,
            Size => 10,
            Data => {
                %QueueList,
            },
        },
        {
            Frontend => 'Customers',
            Name => 'Customers',
            Multiple => 1,
            Size => 10,
            Data => {
                %CustomerIDs,
            },
        },
        {
            Frontend => 'Agents',
            Name => 'Agents',
            Multiple => 1,
            Size => 10,
            Data => {
                %UserList,
            },
        },
        {
            Frontend => $LanguageObject->Translate('Month') . ' ' . $LanguageObject->Translate('from'),
            Name => 'Month_From',
            Multiple => 0,
            Size => 1,
            SelectedID => $SelectedYearMonth,
            Data => {
                %YearMonth,
            },
        },
        {
            Frontend => $LanguageObject->Translate('Month') . ' ' . $LanguageObject->Translate('to'),
            Name => 'Month_To',
            Multiple => 0,
            Size => 1,
            SelectedID => $SelectedYearMonth,
            Data => {
                %YearMonth,
            },
        },
        {
            Frontend => $LanguageObject->Translate('Tickets with no accounted time'),
            Name => 'TicketsWithNoAccountedTime',
            Multiple => 0,
            Size => 1,
            SelectedID => 0,
            Data => {
                0 => $LanguageObject->Translate('Show'),
                1 => $LanguageObject->Translate('Hide'),
                2 => $LanguageObject->Translate('Only'),
            },
        },
    );

    if ( $Kernel::OM->Get('Kernel::Config')->Get('Ticket::Service') ) {
        my %Services = $Kernel::OM->Get('Kernel::System::Service')->ServiceList(
            UserID => 1,
        );

        my %SLAs = $Kernel::OM->Get('Kernel::System::SLA')->SLAList(
            UserID => 1,
        );

        my @ParamsAdd = (
            {
                Frontend => 'Services',
                Name => 'Services',
                Multiple => 1,
                Size => 10,
                Data => {
                    %Services,
                },
            },
            {
                Frontend => $LanguageObject->Translate('Show Service column'),
                Name => 'ShowServiceColumn',
                Multiple => 0,
                Size => 1,
                SelectedID => 1,
                Data => {
                    0 => $LanguageObject->Translate('No'),
                    1 => $LanguageObject->Translate('Yes'),
                },
            },
            {
                Frontend => 'SLA',
                Name => 'SLA',
                Multiple => 1,
                Size => 10,
                Data => {
                    %SLAs,
                },
            },
        );

        unshift @Params, @ParamsAdd;
    }

    return @Params;
}

# Convert YYYYMM number to YYYY-MM string
sub ym_2_str {
    my($ym) = @_;

    my $Year = ( $ym - ($ym % 100) ) / 100;
    my $Month = $ym % 100;

    return sprintf( "%04d-%02d", $Year, $Month );
}

# format decimal number for output
sub fn {
    my($Number) = @_;

    my $NumberStr = sprintf("%.2f", $Number);

    # comma as decimal point
    $NumberStr =~ s/\./,/;

    return $NumberStr;
}


sub Run {
    my ( $Self, %Param ) = @_;

    # get config object
    my $ConfigObject = $Kernel::OM->Get('Kernel::Config');

    # get time object
    my $TimeObject = $Kernel::OM->Get('Kernel::System::Time');

    # get language object
    my $LanguageObject = $Kernel::OM->Get('Kernel::Language');

    # get current time
    my ($s,$m,$h, $D,$M,$Y) = $TimeObject->SystemTime2Date(
        SystemTime => $TimeObject->SystemTime(),
    );

    # set correct date order n case of user input mistake
    my $start_month = $Param{Month_From} <= $Param{Month_To} ? ym_2_str($Param{Month_From}) : ym_2_str($Param{Month_To});
    my $end_month   = $Param{Month_From} <= $Param{Month_To} ? ym_2_str($Param{Month_To})   : ym_2_str($Param{Month_From});

    my $Title = $LanguageObject->Translate('from') . ' ' . $start_month . ' ' . $LanguageObject->Translate('to') . ' ' .  $end_month;

    my %StatusMapping =
    (
        'new' =>              $LanguageObject->Translate('new'),
        'open' =>             $LanguageObject->Translate('open'),
        'closed' =>           $LanguageObject->Translate('closed'),
        'pending reminder' => $LanguageObject->Translate('pending'),
        'pending auto' =>     $LanguageObject->Translate('pending'),
        'removed' =>          $LanguageObject->Translate('removed'),
        'merged' =>           $LanguageObject->Translate('merged'),
    );

    my @Data;

    my $StatesFilter = '';
    if ( $Param{States} && @{$Param{States}} ) {
        $StatesFilter = " and t.ticket_state_id in ('" . join("', '", @{$Param{States}}) . "')";
    }

    my $CustomerFilter = '';
    if ( $Param{Customers} && @{$Param{Customers}} ) {
        $CustomerFilter = " and t.customer_id in ('" . join("', '", @{$Param{Customers}}) . "')";
    }

    my $ServiceFilter = '';
    if ( $Param{Services} && @{$Param{Services}} ) {
        $ServiceFilter = " and t.service_id in ('" . join("', '", @{$Param{Services}}) . "')";
    }

    my $SLAFilter = '';
    if ( $Param{SLA} && @{$Param{SLA}} ) {
        $SLAFilter = " and t.sla_id in ('" . join("', '", @{$Param{SLA}}) . "')";
    }

    my $QueueFilter = '';
    if ( $Param{Queues} && @{$Param{Queues}} ) {
        $QueueFilter = " and q.id in ('" . join("', '", @{$Param{Queues}}) . "')";
    }

    my $AgentFilter = '';
    if ( $Param{Agents} && @{$Param{Agents}} ) {
        $AgentFilter = " and a.create_by in ('" . join("', '", @{$Param{Agents}}) . "')";
    }

    my $AccTimeFilter = '';
    if ( $Param{TicketsWithNoAccountedTime} == 2 ) {
        $AccTimeFilter = ' having sum(ifnull(ta.time_unit, 0)) <= 0';
    }
    elsif ( $Param{TicketsWithNoAccountedTime} == 1 ) {
        $AccTimeFilter = ' having sum(ifnull(ta.time_unit, 0)) > 0';
    }

    # hide service column if function not enabled in sysconfig
    my $service_col_sql = '';
    my $service_col_offset = -1;
    my @HeadData;
    if ( $ConfigObject->Get('Ticket::Service') && ( $Param{ShowServiceColumn} == 1 ) ) {
        $service_col_sql = 's.name as service,';
        $service_col_offset = 0;
        @HeadData = (
            $LanguageObject->Translate('Ticket'),
            $LanguageObject->Translate('Customer'),
            $LanguageObject->Translate('Title'),
            $LanguageObject->Translate('Created'),
            $LanguageObject->Translate('State'),
            $LanguageObject->Translate('Service'),
            $LanguageObject->Translate('Accounted time'),
        );
    }
    else {
        @HeadData = (
            $LanguageObject->Translate('Ticket'),
            $LanguageObject->Translate('Customer'),
            $LanguageObject->Translate('Title'),
            $LanguageObject->Translate('Created'),
            $LanguageObject->Translate('State'),
            $LanguageObject->Translate('Accounted time'),
        );
    }

    my $SQL = "SELECT
            t.tn as number,
            if(length(t.customer_user_id) <= 37, t.customer_user_id, concat(substring(t.customer_user_id, 1, 37), '...')) as customer,
            if(length(t.title) <= 47, t.title, concat(substring(t.title, 1, 47), '...')) as title,
            date(t.create_time) as create_time,
            tst.name as state," .
            $service_col_sql . "
            sum(ifnull(ta.time_unit, 0)) as acc_time
        FROM article as a
           inner join ticket as t on t.id = a.ticket_id
           inner join queue as q on q.id = t.queue_id
           left outer join time_accounting as ta on ta.article_id = a.id
           left outer join service as s on s.id = t.service_id
           left outer join ticket_state as ts on ts.id = t.ticket_state_id
           left outer join ticket_state_type as tst on tst.id = ts.type_id
        WHERE (datediff(a.create_time, '" . $start_month . "-01') >= 0 and datediff(a.create_time, DATE_ADD('" . $end_month . "-01', INTERVAL 1 MONTH)) < 0)" .
            $StatesFilter . $CustomerFilter . $ServiceFilter . $SLAFilter . $QueueFilter . $AgentFilter . "
        GROUP BY t.tn" . $AccTimeFilter . " ORDER BY t.tn asc";

#    # DEGUG
#    $Self->{LogObject}->Log(
#        Priority => 'error',
#        Message  => $SQL,
#    );

    my $DBObject = $Kernel::OM->Get('Kernel::System::DB');
    $DBObject->Prepare( SQL => $SQL );

    my $total = 0;

    while ( my @row = $DBObject->FetchrowArray() )
    {
        $total = $total + $row[6 + $service_col_offset];
        $row[0] = $ConfigObject->Get('Ticket::Hook') . $row[0];
        $row[4] = $StatusMapping{$row[4]} ? $StatusMapping{$row[4]} : $row[4];
        $row[6 + $service_col_offset] = fn($row[6 + $service_col_offset]);
        push (@Data, \@row);
    }

    if ( $ConfigObject->Get('Ticket::Service') && ( $Param{ShowServiceColumn} == 1 ) ) {
        push (@Data, [$LanguageObject->Translate('Sum'), '', '', '', '', '', fn($total)]);
    }
    else {
        push (@Data, [$LanguageObject->Translate('Sum'), '', '', '', '', fn($total)]);
    }

    return ([$Title], [@HeadData], @Data);
}

1;
