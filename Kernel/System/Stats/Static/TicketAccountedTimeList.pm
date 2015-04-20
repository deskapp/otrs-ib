# --
# Kernel/System/Stats/Static/TicketAccountedTimeList.pm - module for accounted time reporting
# Copyright (C) 2015 Informatyka Boguslawski sp. z o.o. sp.k., http://www.ib.pl/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

# Warning: systems with a lot of articles may need extra index on article.create_time
# column or reporting using this module will be slow.

package Kernel::System::Stats::Static::TicketAccountedTimeList;

use strict;
use warnings;
use Kernel::Language;
use Kernel::System::Queue;
use Kernel::System::CustomerUser;
use Kernel::System::Service;
use Kernel::System::SLA;
use Kernel::System::State;

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = { %Param };
    bless( $Self, $Type );

    # check all needed objects
    for (qw(ConfigObject EncodeObject LogObject DBObject UserObject)) {
        die "Got no $_" if ( !$Self->{$_} );
    }

    $Self->{LangugageObject}    = Kernel::Language->new(%Param);
    $Self->{QueueObject}        = Kernel::System::Queue->new(%Param);
    $Self->{CustomerUserObject} = Kernel::System::CustomerUser->new(%Param);
    $Self->{ServiceObject}      = Kernel::System::Service->new(%Param);
    $Self->{SLAObject}          = Kernel::System::SLA->new(%Param);
    $Self->{StateObject}        = Kernel::System::State->new(%Param);

    return $Self;
}

sub Param {
    my $Self = shift;

    # get current time
    my ($s,$m,$h, $D,$M,$Y) = $Self->{TimeObject}->SystemTime2Date(
        SystemTime => $Self->{TimeObject}->SystemTime(),
    );

    # period limit
    my $FirstYearMonth = (2010 * 100) + 1;

    # one month before as default selection
    my $SelectedYear  = $M == 1 ? $Y - 1 : $Y;
    my $SelectedMonth = $M == 1 ? 12     : $M - 1;
    my $SelectedYearMonth = ($SelectedYear * 100) + $SelectedMonth;

    my %YearMonth = ();

    for (my $year = $Y - 10; $year <= $Y; $year++)
    {
        for(my $month = 1; ($month < 13) && ( $year*100 + $month <= $Y*100 + $M ) ; $month++)
        {
                if ( ($year*100)+$month >= $FirstYearMonth )
            {
                $YearMonth{ ($year*100)+$month } = sprintf( "%04d-%02d", $year, $month) ;
            }
        }
    }

    my %QueueList = $Self->{QueueObject}->QueueList(
        Valid => 1,
    );

    my %CustomerIDs = map {$_, $_} $Self->{CustomerUserObject}->CustomerIDList(
        Valid => 1,
    );

    my %UserList = $Self->{UserObject}->UserList(
        Type => 'Short',
        Valid => 1,
    );

    my %StateList = $Self->{StateObject}->StateList(
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
            Frontend => $Self->{LangugageObject}->Get('Month') . ' ' . $Self->{LangugageObject}->Get('from'),
            Name => 'Month_From',
            Multiple => 0,
            Size => 1,
            SelectedID => $SelectedYearMonth,
            Data => {
                %YearMonth,
            },
        },
        {
            Frontend => $Self->{LangugageObject}->Get('Month') . ' ' . $Self->{LangugageObject}->Get('to'),
            Name => 'Month_To',
            Multiple => 0,
            Size => 1,
            SelectedID => $SelectedYearMonth,
            Data => {
                %YearMonth,
            },
        },
        {
            Frontend => $Self->{LangugageObject}->Get('Tickets with no accounted time'),
            Name => 'TicketsWithNoAccountedTime',
            Multiple => 0,
            Size => 1,
            SelectedID => 0,
            Data => {
                0 => $Self->{LangugageObject}->Get('Show'),
                1 => $Self->{LangugageObject}->Get('Hide'),
                2 => $Self->{LangugageObject}->Get('Only'),
            },
        },
    );

    if ( $Self->{ConfigObject}->Get('Ticket::Service') ) {
        my %Services = $Self->{ServiceObject}->ServiceList(
            UserID => 1,
        );

        my %SLAs = $Self->{SLAObject}->SLAList(
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
                Frontend => $Self->{LangugageObject}->Get('Show Service column'),
                Name => 'ShowServiceColumn',
                Multiple => 0,
                Size => 1,
                SelectedID => 1,
                Data => {
                    0 => $Self->{LangugageObject}->Get('No'),
                    1 => $Self->{LangugageObject}->Get('Yes'),
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

    my $year = ( $ym - ($ym % 100) ) / 100;
    my $month = $ym % 100;

    return sprintf( "%04d-%02d", $year, $month );
}

# format decimal number for output
sub fn {
    my($number) = @_;

    my $number_str = sprintf("%.2f", $number);

    # comma as decimal point
    $number_str =~ s/\./,/;

    return $number_str;
}


sub Run {
    my ( $Self, %Param ) = @_;

    # get current time
    my ($s,$m,$h, $D,$M,$Y) = $Self->{TimeObject}->SystemTime2Date(
        SystemTime => $Self->{TimeObject}->SystemTime(),
    );

    # set correct date order n case of user input mistake
    my $start_month = $Param{Month_From} <= $Param{Month_To} ? ym_2_str($Param{Month_From}) : ym_2_str($Param{Month_To});
    my $end_month   = $Param{Month_From} <= $Param{Month_To} ? ym_2_str($Param{Month_To})   : ym_2_str($Param{Month_From});

    my $Title = $Self->{LangugageObject}->Get('from') . ' ' . $start_month . ' ' . $Self->{LangugageObject}->Get('to') . ' ' .  $end_month;

    my %StatusMapping =
    (
        'new' =>              $Self->{LangugageObject}->Get('new'),
        'open' =>             $Self->{LangugageObject}->Get('open'),
        'closed' =>           $Self->{LangugageObject}->Get('closed'),
        'pending reminder' => $Self->{LangugageObject}->Get('pending'),
        'pending auto' =>     $Self->{LangugageObject}->Get('pending'),
        'removed' =>          $Self->{LangugageObject}->Get('removed'),
        'merged' =>           $Self->{LangugageObject}->Get('merged'),
    );

    my @Data;

    my $StatesFilter = '';
    if ($Param{States} && @{$Param{States}}) {
        $StatesFilter = " and t.ticket_state_id in ('" . join("', '", @{$Param{States}}) . "')";
    }

    my $CustomerFilter = '';
    if ($Param{Customers} && @{$Param{Customers}}) {
        $CustomerFilter = " and t.customer_id in ('" . join("', '", @{$Param{Customers}}) . "')";
    }

    my $ServiceFilter = '';
    if ($Param{Services} && @{$Param{Services}}) {
        $ServiceFilter = " and t.service_id in ('" . join("', '", @{$Param{Services}}) . "')";
    }

    my $SLAFilter = '';
    if ($Param{SLA} && @{$Param{SLA}}) {
        $SLAFilter = " and t.sla_id in ('" . join("', '", @{$Param{SLA}}) . "')";
    }

    my $QueueFilter = '';
    if ($Param{Queues} && @{$Param{Queues}}) {
        $QueueFilter = " and q.id in ('" . join("', '", @{$Param{Queues}}) . "')";
    }

    my $AgentFilter = '';
    if ($Param{Agents} && @{$Param{Agents}}) {
        $AgentFilter = " and a.create_by in ('" . join("', '", @{$Param{Agents}}) . "')";
    }

    my $AccTimeFilter = '';
    if ($Param{TicketsWithNoAccountedTime} == 2) {
        $AccTimeFilter = ' having sum(ifnull(ta.time_unit, 0)) <= 0';
    }
    elsif ($Param{TicketsWithNoAccountedTime} == 1) {
        $AccTimeFilter = ' having sum(ifnull(ta.time_unit, 0)) > 0';
    }

    # hide service column if function not enabled in sysconfig
    my $service_col_sql = '';
    my $service_col_offset = -1;
    my @HeadData;
    if ( $Self->{ConfigObject}->Get('Ticket::Service') && ($Param{ShowServiceColumn} == 1) ) {
        $service_col_sql = 's.name as service,';
        $service_col_offset = 0;
        @HeadData = (
            $Self->{LangugageObject}->Get('Ticket'),
            $Self->{LangugageObject}->Get('Customer'),
            $Self->{LangugageObject}->Get('Title'),
            $Self->{LangugageObject}->Get('Created'),
            $Self->{LangugageObject}->Get('State'),
            $Self->{LangugageObject}->Get('Service'),
            $Self->{LangugageObject}->Get('Accounted time'),
        );
    }
    else {
        @HeadData = (
            $Self->{LangugageObject}->Get('Ticket'),
            $Self->{LangugageObject}->Get('Customer'),
            $Self->{LangugageObject}->Get('Title'),
            $Self->{LangugageObject}->Get('Created'),
            $Self->{LangugageObject}->Get('State'),
            $Self->{LangugageObject}->Get('Accounted time'),
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

    $Self->{DBObject}->Prepare( SQL => $SQL );

    my $total = 0;

    while ( my @row = $Self->{DBObject}->FetchrowArray() )
    {
        $total = $total + $row[6 + $service_col_offset];
        $row[0] = $Self->{ConfigObject}->Get('Ticket::Hook') . $row[0];
        $row[4] = $StatusMapping{$row[4]} ? $StatusMapping{$row[4]} : $row[4];
        $row[6 + $service_col_offset] = fn($row[6 + $service_col_offset]);
        push (@Data, \@row);
    }

    if ( $Self->{ConfigObject}->Get('Ticket::Service') && ($Param{ShowServiceColumn} == 1) ) {
        push (@Data, [$Self->{LangugageObject}->Get('Sum'), '', '', '', '', '', fn($total)]);
    }
    else {
        push (@Data, [$Self->{LangugageObject}->Get('Sum'), '', '', '', '', fn($total)]);
    }

    return ([$Title], [@HeadData], @Data);
}

1;
