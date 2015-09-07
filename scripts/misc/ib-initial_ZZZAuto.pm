# OTRS config file (automatically generated)
# VERSION:1.1
package Kernel::Config::Files::ZZZAuto;
use strict;
use warnings;
use utf8;
{ no warnings 'redefine'; sub Load {
    my ($File, $Self) = @_;
$Self->{'Ticket::Frontend::AgentTicketMerge'}->{'RichTextHeight'} =  '320';
$Self->{'Ticket::Frontend::AgentTicketMerge'}->{'RichTextWidth'} =  '650';
$Self->{'Ticket::Frontend::AgentTicketForward'}->{'RichTextHeight'} =  '320';
$Self->{'Ticket::Frontend::AgentTicketForward'}->{'RichTextWidth'} =  '650';
$Self->{'Ticket::Frontend::AgentTicketResponsible'}->{'RichTextHeight'} =  '320';
$Self->{'Ticket::Frontend::AgentTicketResponsible'}->{'RichTextWidth'} =  '650';
$Self->{'Ticket::Frontend::AgentTicketPriority'}->{'RichTextHeight'} =  '320';
$Self->{'Ticket::Frontend::AgentTicketPriority'}->{'RichTextWidth'} =  '650';
$Self->{'Ticket::Frontend::AgentTicketFreeText'}->{'RichTextHeight'} =  '320';
$Self->{'Ticket::Frontend::AgentTicketFreeText'}->{'RichTextWidth'} =  '650';
$Self->{'Ticket::Frontend::AgentTicketClose'}->{'RichTextHeight'} =  '320';
$Self->{'Ticket::Frontend::AgentTicketClose'}->{'RichTextWidth'} =  '650';
$Self->{'Ticket::Frontend::AgentTicketPhoneOutbound'}->{'RichTextWidth'} =  '450';
$Self->{'Ticket::Frontend::AgentTicketPhoneInbound'}->{'RichTextWidth'} =  '450';
$Self->{'Ticket::Frontend::AgentTicketPhone'}->{'RichTextWidth'} =  '650';
$Self->{'Ticket::Frontend::AgentTicketEmail'}->{'RichTextWidth'} =  '650';
$Self->{'Ticket::Frontend::AgentTicketPending'}->{'RichTextHeight'} =  '320';
$Self->{'Ticket::Frontend::AgentTicketPending'}->{'RichTextWidth'} =  '650';
$Self->{'Ticket::Frontend::AgentTicketOwner'}->{'RichTextHeight'} =  '320';
$Self->{'Ticket::Frontend::AgentTicketOwner'}->{'RichTextWidth'} =  '650';
$Self->{'Ticket::Frontend::AgentTicketNote'}->{'RichTextHeight'} =  '320';
$Self->{'Ticket::Frontend::AgentTicketNote'}->{'RichTextWidth'} =  '650';
$Self->{'PostmasterDefaultQueue'} =  "Zg\x{142}oszenia";
$Self->{'PostmasterFollowUpSearchInReferences'} =  '1';
$Self->{'Frontend::ToolBarModule'}->{'11-CICSearchCustomerUser'} =  {
  'Block' => 'ToolBarCICSearchCustomerUser',
  'CSS' => 'Core.Agent.Toolbar.CICSearch.css',
  'Description' => 'CustomerUser Search',
  'Module' => 'Kernel::Output::HTML::ToolBarGeneric',
  'Name' => 'Customer user search',
  'Priority' => '1990040',
  'Size' => '20'
};
$Self->{'Frontend::ToolBarModule'}->{'10-Ticket::TicketSearchFulltext'} =  {
  'Block' => 'ToolBarSearchFulltext',
  'CSS' => 'Core.Agent.Toolbar.FulltextSearch.css',
  'Description' => 'Fulltext-Search',
  'Module' => 'Kernel::Output::HTML::ToolBarGeneric',
  'Name' => 'Fulltext-Search',
  'Priority' => '1990020',
  'Size' => '20'
};
$Self->{'Frontend::ToolBarModule'}->{'9-Ticket::TicketSearchProfile'} =  {
  'Block' => 'ToolBarSearchProfile',
  'Description' => 'Search-Template',
  'MaxWidth' => '40',
  'Module' => 'Kernel::Output::HTML::ToolBarTicketSearchProfile',
  'Name' => 'Search-Template',
  'Priority' => '1990010'
};
$Self->{'Frontend::ToolBarModule'}->{'5-Ticket::AgentTicketEmail'} =  {
  'AccessKey' => 'l',
  'Action' => 'AgentTicketEmail',
  'CssClass' => 'EmailTicket',
  'Link' => 'Action=AgentTicketEmail',
  'Module' => 'Kernel::Output::HTML::ToolBarLink',
  'Name' => 'New email ticket',
  'Priority' => '1020020'
};
$Self->{'Frontend::ToolBarModule'}->{'4-Ticket::AgentTicketPhone'} =  {
  'AccessKey' => 'l',
  'Action' => 'AgentTicketPhone',
  'CssClass' => 'PhoneTicket',
  'Link' => 'Action=AgentTicketPhone',
  'Module' => 'Kernel::Output::HTML::ToolBarLink',
  'Name' => 'New phone ticket',
  'Priority' => '1020010'
};
$Self->{'Frontend::ToolBarModule'}->{'3-Ticket::AgentTicketEscalation'} =  {
  'AccessKey' => 'w',
  'Action' => 'AgentTicketEscalationView',
  'CssClass' => 'EscalationView',
  'Link' => 'Action=AgentTicketEscalationView',
  'Module' => 'Kernel::Output::HTML::ToolBarLink',
  'Name' => 'Escalation view',
  'Priority' => '1010030'
};
$Self->{'Frontend::ToolBarModule'}->{'2-Ticket::AgentTicketStatus'} =  {
  'AccessKey' => 'o',
  'Action' => 'AgentTicketStatusView',
  'CssClass' => 'StatusView',
  'Link' => 'Action=AgentTicketStatusView',
  'Module' => 'Kernel::Output::HTML::ToolBarLink',
  'Name' => 'Status view',
  'Priority' => '1010020'
};
$Self->{'Frontend::ToolBarModule'}->{'1-Ticket::AgentTicketQueue'} =  {
  'AccessKey' => 'q',
  'Action' => 'AgentTicketQueue',
  'CssClass' => 'QueueView',
  'Link' => 'Action=AgentTicketQueue',
  'Module' => 'Kernel::Output::HTML::ToolBarLink',
  'Name' => 'Queue view',
  'Priority' => '1010010'
};
$Self->{'Ticket::Frontend::AutomaticMergeText'} =  "Zg\x{142}oszenie <OTRS_CONFIG_Ticket::Hook><OTRS_TICKET> zosta\x{142}o scalone ze zg\x{142}oszeniem <OTRS_CONFIG_Ticket::Hook><OTRS_MERGE_TO_TICKET>.";
$Self->{'Ticket::Frontend::AutomaticMergeSubject'} =  "Zg\x{142}oszenie scalone";
$Self->{'Ticket::Frontend::MergeText'} =  "Pa\x{144}stwa zg\x{142}oszenie o numerze <OTRS_CONFIG_Ticket::Hook><OTRS_TICKET> zosta\x{142}o scalone ze zg\x{142}oszeniem o numerze <OTRS_CONFIG_Ticket::Hook><OTRS_MERGE_TO_TICKET>.";
$Self->{'Ticket::Frontend::ResponseFormat'} =  '$QData{"Salutation"}

$QData{"StdResponse"}

$QData{"Signature"}

________________________________

$Text{" On"} $TimeShort{"$QData{"Created"}"}, $QData{"OrigFromName"} $Text{"wrote"}:
$QData{"Body"}

';
$Self->{'Ticket::Frontend::BounceText'} =  "Pa\x{144}stwa zg\x{142}oszenie o numerze <OTRS_CONFIG_Ticket::Hook><OTRS_TICKET> zosta\x{142}o przekazane na adres

   <OTRS_BOUNCE_TO>
   
Prosimy kontaktowa\x{107} si\x{119} pod tym adresem we wszystkich sprawach dotycz\x{105}cych
tego zg\x{142}oszenia.";
$Self->{'Ticket::Frontend::AgentTicketSearch'}->{'Defaults'}->{'QueueIDs'} =  [];
$Self->{'Ticket::Frontend::AgentTicketSearch'}->{'Defaults'}->{'StateIDs'} =  [];
$Self->{'Ticket::Frontend::AgentTicketSearch'}->{'Defaults'}->{'CustomerID'} =  '';
$Self->{'Ticket::Frontend::AgentTicketSearch'}->{'Defaults'}->{'Subject'} =  '';
$Self->{'Ticket::Frontend::AgentTicketSearch'}->{'Defaults'}->{'To'} =  '';
$Self->{'Ticket::Frontend::AgentTicketSearch'}->{'Defaults'}->{'From'} =  '';
$Self->{'Ticket::Frontend::AgentTicketSearch'}->{'Defaults'}->{'TicketNumber'} =  '';
$Self->{'Ticket::Frontend::TicketArticleFilter'} =  '1';
$Self->{'Ticket::UseArticleColors'} =  '1';
$Self->{'Ticket::Frontend::PlainView'} =  '1';
$Self->{'Ticket::Frontend::RealnameOnly'} =  '0';
$Self->{'Ticket::Watcher'} =  '1';
$Self->{'Process::DefaultQueue'} =  'Kosz';
$Self->{'Loader::Customer::SelectedSkin'} =  'hdesk.pl';
$Self->{'Loader::Agent::DefaultSelectedSkin'} =  'hdesk.pl';
$Self->{'DashboardBackend'}->{'0410-RSS'} =  {
  'Block' => 'ContentSmall',
  'CacheTTL' => '360',
  'Default' => '1',
  'Description' => '',
  'Group' => '',
  'Limit' => '6',
  'Module' => 'Kernel::Output::HTML::DashboardRSS',
  'Title' => 'News',
  'URL' => 'http://www.ib.pl/feed/rss.html'
};
$Self->{'Stats::UseAgentElementInStats'} =  '1';
$Self->{'CustomerPanelBodyNewAccount'} =  "(For English see below)

Witaj <OTRS_USERFIRSTNAME>,

Ty lub kto\x{15b} podaj\x{105}cy si\x{119} za ciebie utworzy\x{142} nowe konto w systemie
<OTRS_CONFIG_ProductName> dla ciebie (<OTRS_USERFIRSTNAME> <OTRS_USERLASTNAME>).

   Nazwa u\x{17c}ytkownika: <OTRS_USERLOGIN>
   Has\x{142}o:             <OTRS_USERPASSWORD>
   Strona logowania:  <OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/

Aby zapewni\x{107} poufno\x{15b}\x{107} twojego has\x{142}a, zaloguj si\x{119} mo\x{17c}liwie
szybko przy u\x{17c}yciu powy\x{17c}szych danych i zmie\x{144} has\x{142}o na w\x{142}asne
korzystaj\x{105}c z opcji Ustawienia > Zmiana has\x{142}a.

System <OTRS_CONFIG_ProductName>
W: <OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/

_________________________________________________


Hi <OTRS_USERFIRSTNAME>,

You or someone impersonating you has created a new <OTRS_CONFIG_ProductName>
account for you (<OTRS_USERFIRSTNAME> <OTRS_USERLASTNAME>).

   Username:   <OTRS_USERLOGIN>
   Password:   <OTRS_USERPASSWORD>
   Login page: <OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/

To ensure the confidentiality of your password, log in using
above information and set your own password using the Settings >
Change Password option as soon as possible.   

<OTRS_CONFIG_ProductName> System
W: <OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/

";
$Self->{'CustomerPanelSubjectNewAccount'} =  'Nowe konto / New account';
$Self->{'CustomerPanelBodyLostPassword'} =  "(For English see below)

Witaj <OTRS_USERFIRSTNAME>,

Ty lub kto\x{15b} podaj\x{105}cy si\x{119} za ciebie za\x{17c}\x{105}da\x{142} zmiany twojego
has\x{142}a w systemie <OTRS_CONFIG_ProductName>.

  Twoje nowe has\x{142}o: <OTRS_NEWPW>
  Strona logowania: <OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/
  
Aby zapewni\x{107} poufno\x{15b}\x{107} twojego has\x{142}a, zaloguj si\x{119} mo\x{17c}liwie
szybko przy u\x{17c}yciu powy\x{17c}szych danych i zmie\x{144} has\x{142}o na w\x{142}asne
korzystaj\x{105}c z opcji Ustawienia > Zmiana has\x{142}a.

System <OTRS_CONFIG_ProductName>
W: <OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/

_________________________________________________


Hi <OTRS_USERFIRSTNAME>,

You or someone impersonating you has requested to change your
<OTRS_CONFIG_ProductName> password.

  Your new password: <OTRS_NEWPW>
  Login page:        <OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/
  
To ensure the confidentiality of your password, log in using
above information and set your own password using the Settings >
Change Password option as soon as possible. 

<OTRS_CONFIG_ProductName> System
W: <OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/

";
$Self->{'CustomerPanelSubjectLostPassword'} =  "Nowe has\x{142}o / New password";
$Self->{'CustomerPanelBodyLostPasswordToken'} =  "(For English see below)

Witaj <OTRS_USERFIRSTNAME>,

Ty lub kto\x{15b} podaj\x{105}cy si\x{119} za ciebie za\x{17c}\x{105}da\x{142} zmiany twojego
has\x{142}a w systemie <OTRS_CONFIG_ProductName>.

Je\x{15b}li chcesz otrzyma\x{107} nowe has\x{142}o, kliknij poni\x{17c}szy link:
<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>customer.pl?Action=CustomerLostPassword&Token=<OTRS_TOKEN>

System <OTRS_CONFIG_ProductName>
W: <OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/

_________________________________________________


Hi <OTRS_USERFIRSTNAME>,

You or someone impersonating you has requested to change your
<OTRS_CONFIG_ProductName> system password.

If you want to get a new password, click on this link:
<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>customer.pl?Action=CustomerLostPassword&Token=<OTRS_TOKEN>

<OTRS_CONFIG_ProductName> System
W: <OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/

";
$Self->{'CustomerPanelSubjectLostPasswordToken'} =  "\x{17b}\x{105}danie zmiany has\x{142}a / New password request";
$Self->{'NotificationBodyLostPassword'} =  "(For English see below)

Witaj <OTRS_USERFIRSTNAME>,

Ty lub kto\x{15b} podaj\x{105}cy si\x{119} za ciebie za\x{17c}\x{105}da\x{142} zmiany twojego
has\x{142}a w systemie <OTRS_CONFIG_ProductName>.

  Nowe has\x{142}o:       <OTRS_NEWPW>
  Strona logowania: <OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/agent/

Aby zapewni\x{107} poufno\x{15b}\x{107} twojego has\x{142}a, zaloguj si\x{119} mo\x{17c}liwie
szybko przy u\x{17c}yciu powy\x{17c}szych danych i zmie\x{144} has\x{142}o na w\x{142}asne
korzystaj\x{105}c z opcji Ustawienia > Zmiana has\x{142}a.

System <OTRS_CONFIG_ProductName>
W: <OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/

_________________________________________________


Hi <OTRS_USERFIRSTNAME>,

You or someone impersonating you has requested to change your
<OTRS_CONFIG_ProductName> password.

  New password: <OTRS_NEWPW>
  Login page:   <OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/agent/

To ensure the confidentiality of your password, log in using
above information and set your own password using the Settings >
Change Password option as soon as possible.   

<OTRS_CONFIG_ProductName> System
W: <OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/

";
$Self->{'NotificationSubjectLostPassword'} =  "Nowe has\x{142}o / New password";
$Self->{'NotificationBodyLostPasswordToken'} =  "(For English see below)

Witaj <OTRS_USERFIRSTNAME>,

Ty lub kto\x{15b} podaj\x{105}cy si\x{119} za ciebie za\x{17c}\x{105}da\x{142} zmiany twojego
has\x{142}a w systemie <OTRS_CONFIG_ProductName>.

Je\x{15b}li chcesz otrzyma\x{107} nowe has\x{142}o, kliknij poni\x{17c}szy link:
<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=LostPassword&Token=<OTRS_TOKEN>

System <OTRS_CONFIG_ProductName>
W: <OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/

_________________________________________________


Hi <OTRS_USERFIRSTNAME>,

You or someone impersonating you has requested to change your
<OTRS_CONFIG_ProductName> system password.

If you want to get a new password, click on this link:
<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=LostPassword&Token=<OTRS_TOKEN>

<OTRS_CONFIG_ProductName> System
W: <OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/

";
$Self->{'NotificationSubjectLostPasswordToken'} =  "\x{17b}\x{105}danie nowego has\x{142}a / New password request";
$Self->{'PDF::SkinColor'} =  '#3780b4';
$Self->{'SubstMalformedChars'} =  '1';
$Self->{'FindURIEnabled'} =  '1';
$Self->{'Frontend::RichText::MailCSS'} =  'a, a:visited, a:active
{
    color: #3D80B2;
    text-decoration: none;
}

a:hover
{
    color: #3D80B2;
    text-decoration: underline;
}

th, td, caption {
    font-family: Verdana, \'Bitstream Vera Sans\', \'DejaVu Sans\', Tahoma, Geneva, Arial, Sans-serif;
    font-size: 10pt;
}
';
$Self->{'Frontend::RichText::EditingAreaCSS'} =  '.cke_editable { line-height: normal; margin: 10px; }';
$Self->{'Frontend::RichTextWidth'} =  '650';
$Self->{'ExtFQDN'} =  'helpdesk.ib.loc';
$Self->{'Ticket::SearchIndexModule'} =  'Kernel::System::Ticket::ArticleSearchIndex::StaticDB';
$Self->{'Ticket::SearchIndex::Filters'} =  [];
$Self->{'Ticket::IndexModule'} =  'Kernel::System::Ticket::IndexAccelerator::StaticDB';
$Self->{'Frontend::ToolBarModule'}->{'9-Ticket::TicketSearchProfile'} =  {
  'Block' => 'ToolBarSearchProfile',
  'Description' => 'Search-Template',
  'MaxWidth' => '40',
  'Module' => 'Kernel::Output::HTML::ToolBarTicketSearchProfile',
  'Name' => 'Search-Template',
  'Priority' => '1990010'
};
$Self->{'DashboardBackend'}->{'0100-TicketPendingReminder'} =  {
  'Attributes' => 'TicketPendingTimeOlderMinutes=1;StateType=pending reminder;SortBy=PendingTime;OrderBy=Down;',
  'Block' => 'ContentLarge',
  'CacheTTLLocal' => '0.5',
  'Default' => '1',
  'DefaultColumns' => {
    'Age' => '150',
    'Changed' => '1',
    'CustomerID' => '1',
    'CustomerName' => '1',
    'CustomerUserID' => '110',
    'EscalationResponseTime' => '1',
    'EscalationSolutionTime' => '1',
    'EscalationTime' => '1',
    'EscalationUpdateTime' => '1',
    'Lock' => '1',
    'Owner' => '140',
    'PendingTime' => '1',
    'Priority' => '1',
    'Queue' => '130',
    'Responsible' => '1',
    'SLA' => '1',
    'Service' => '1',
    'State' => '1',
    'TicketNumber' => '100',
    'Title' => '120',
    'Type' => '1'
  },
  'Description' => 'All tickets with a reminder set where the reminder date has been reached',
  'Filter' => 'Locked',
  'Group' => '',
  'Limit' => '10',
  'Module' => 'Kernel::Output::HTML::DashboardTicketGeneric',
  'Permission' => 'rw',
  'Time' => 'UntilTime',
  'Title' => 'Reminder Tickets'
};
$Self->{'DashboardBackend'}->{'0110-TicketEscalation'} =  {
  'Attributes' => 'TicketEscalationTimeOlderMinutes=1;SortBy=EscalationTime;OrderBy=Down;',
  'Block' => 'ContentLarge',
  'CacheTTLLocal' => '0.5',
  'Default' => '1',
  'DefaultColumns' => {
    'Age' => '150',
    'Changed' => '1',
    'CustomerID' => '1',
    'CustomerName' => '1',
    'CustomerUserID' => '110',
    'EscalationResponseTime' => '1',
    'EscalationSolutionTime' => '1',
    'EscalationTime' => '1',
    'EscalationUpdateTime' => '1',
    'Lock' => '1',
    'Owner' => '140',
    'PendingTime' => '1',
    'Priority' => '1',
    'Queue' => '130',
    'Responsible' => '1',
    'SLA' => '1',
    'Service' => '1',
    'State' => '1',
    'TicketNumber' => '100',
    'Title' => '120',
    'Type' => '1'
  },
  'Description' => 'All escalated tickets',
  'Filter' => 'All',
  'Group' => '',
  'Limit' => '10',
  'Module' => 'Kernel::Output::HTML::DashboardTicketGeneric',
  'Permission' => 'rw',
  'Time' => 'EscalationTime',
  'Title' => 'Escalated Tickets'
};
$Self->{'DashboardBackend'}->{'0120-TicketNew'} =  {
  'Attributes' => 'StateType=new;',
  'Block' => 'ContentLarge',
  'CacheTTLLocal' => '0.5',
  'Default' => '1',
  'DefaultColumns' => {
    'Age' => '150',
    'Changed' => '1',
    'CustomerID' => '1',
    'CustomerName' => '1',
    'CustomerUserID' => '110',
    'EscalationResponseTime' => '1',
    'EscalationSolutionTime' => '1',
    'EscalationTime' => '1',
    'EscalationUpdateTime' => '1',
    'Lock' => '1',
    'Owner' => '140',
    'PendingTime' => '1',
    'Priority' => '1',
    'Queue' => '130',
    'Responsible' => '1',
    'SLA' => '1',
    'Service' => '1',
    'State' => '1',
    'TicketNumber' => '100',
    'Title' => '120',
    'Type' => '1'
  },
  'Description' => 'All new tickets, these tickets have not been worked on yet',
  'Filter' => 'All',
  'Group' => '',
  'Limit' => '10',
  'Module' => 'Kernel::Output::HTML::DashboardTicketGeneric',
  'Permission' => 'rw',
  'Time' => 'Age',
  'Title' => 'New Tickets'
};
$Self->{'DashboardBackend'}->{'0130-TicketOpen'} =  {
  'Attributes' => 'StateType=open;',
  'Block' => 'ContentLarge',
  'CacheTTLLocal' => '0.5',
  'Default' => '1',
  'DefaultColumns' => {
    'Age' => '150',
    'Changed' => '1',
    'CustomerID' => '1',
    'CustomerName' => '1',
    'CustomerUserID' => '110',
    'EscalationResponseTime' => '1',
    'EscalationSolutionTime' => '1',
    'EscalationTime' => '1',
    'EscalationUpdateTime' => '1',
    'Lock' => '1',
    'Owner' => '140',
    'PendingTime' => '1',
    'Priority' => '1',
    'Queue' => '130',
    'Responsible' => '1',
    'SLA' => '1',
    'Service' => '1',
    'State' => '1',
    'TicketNumber' => '100',
    'Title' => '120',
    'Type' => '1'
  },
  'Description' => 'All open tickets, these tickets have already been worked on, but need a response',
  'Filter' => 'All',
  'Group' => '',
  'Limit' => '10',
  'Module' => 'Kernel::Output::HTML::DashboardTicketGeneric',
  'Permission' => 'rw',
  'Time' => 'Age',
  'Title' => 'Open Tickets / Need to be answered'
};
$Self->{'AgentCustomerInformationCenter::Backend'}->{'0100-CIC-TicketPendingReminder'} =  {
  'Attributes' => 'TicketPendingTimeOlderMinutes=1;StateType=pending reminder;SortBy=PendingTime;OrderBy=Down;',
  'Block' => 'ContentLarge',
  'CacheTTLLocal' => '0.5',
  'Default' => '1',
  'DefaultColumns' => {
    'Age' => '150',
    'Changed' => '1',
    'CustomerID' => '1',
    'CustomerName' => '1',
    'CustomerUserID' => '110',
    'EscalationResponseTime' => '1',
    'EscalationSolutionTime' => '1',
    'EscalationTime' => '1',
    'EscalationUpdateTime' => '1',
    'Lock' => '1',
    'Owner' => '140',
    'PendingTime' => '1',
    'Priority' => '1',
    'Queue' => '130',
    'Responsible' => '1',
    'SLA' => '1',
    'Service' => '1',
    'State' => '1',
    'TicketNumber' => '100',
    'Title' => '120',
    'Type' => '1'
  },
  'Description' => 'All tickets with a reminder set where the reminder date has been reached',
  'Filter' => 'Locked',
  'Group' => '',
  'Limit' => '10',
  'Module' => 'Kernel::Output::HTML::DashboardTicketGeneric',
  'Permission' => 'ro',
  'Time' => 'UntilTime',
  'Title' => 'Reminder Tickets'
};
$Self->{'AgentCustomerInformationCenter::Backend'}->{'0110-CIC-TicketEscalation'} =  {
  'Attributes' => 'TicketEscalationTimeOlderMinutes=1;SortBy=EscalationTime;OrderBy=Down;',
  'Block' => 'ContentLarge',
  'CacheTTLLocal' => '0.5',
  'Default' => '1',
  'DefaultColumns' => {
    'Age' => '150',
    'Changed' => '1',
    'CustomerID' => '1',
    'CustomerName' => '1',
    'CustomerUserID' => '110',
    'EscalationResponseTime' => '1',
    'EscalationSolutionTime' => '1',
    'EscalationTime' => '1',
    'EscalationUpdateTime' => '1',
    'Lock' => '1',
    'Owner' => '140',
    'PendingTime' => '1',
    'Priority' => '1',
    'Queue' => '130',
    'Responsible' => '1',
    'SLA' => '1',
    'Service' => '1',
    'State' => '1',
    'TicketNumber' => '100',
    'Title' => '120',
    'Type' => '1'
  },
  'Description' => 'All escalated tickets',
  'Filter' => 'All',
  'Group' => '',
  'Limit' => '10',
  'Module' => 'Kernel::Output::HTML::DashboardTicketGeneric',
  'Permission' => 'ro',
  'Time' => 'EscalationTime',
  'Title' => 'Escalated Tickets'
};
$Self->{'AgentCustomerInformationCenter::Backend'}->{'0120-CIC-TicketNew'} =  {
  'Attributes' => 'StateType=new;',
  'Block' => 'ContentLarge',
  'CacheTTLLocal' => '0.5',
  'Default' => '1',
  'DefaultColumns' => {
    'Age' => '150',
    'Changed' => '1',
    'CustomerID' => '1',
    'CustomerName' => '1',
    'CustomerUserID' => '110',
    'EscalationResponseTime' => '1',
    'EscalationSolutionTime' => '1',
    'EscalationTime' => '1',
    'EscalationUpdateTime' => '1',
    'Lock' => '1',
    'Owner' => '140',
    'PendingTime' => '1',
    'Priority' => '1',
    'Queue' => '130',
    'Responsible' => '1',
    'SLA' => '1',
    'Service' => '1',
    'State' => '1',
    'TicketNumber' => '100',
    'Title' => '120',
    'Type' => '1'
  },
  'Description' => 'All new tickets, these tickets have not been worked on yet',
  'Filter' => 'All',
  'Group' => '',
  'Limit' => '10',
  'Module' => 'Kernel::Output::HTML::DashboardTicketGeneric',
  'Permission' => 'ro',
  'Time' => 'Age',
  'Title' => 'New Tickets'
};
$Self->{'AgentCustomerInformationCenter::Backend'}->{'0130-CIC-TicketOpen'} =  {
  'Attributes' => 'StateType=open;',
  'Block' => 'ContentLarge',
  'CacheTTLLocal' => '0.5',
  'Default' => '1',
  'DefaultColumns' => {
    'Age' => '150',
    'Changed' => '1',
    'CustomerID' => '1',
    'CustomerName' => '1',
    'CustomerUserID' => '110',
    'EscalationResponseTime' => '1',
    'EscalationSolutionTime' => '1',
    'EscalationTime' => '1',
    'EscalationUpdateTime' => '1',
    'Lock' => '1',
    'Owner' => '140',
    'PendingTime' => '1',
    'Priority' => '1',
    'Queue' => '130',
    'Responsible' => '1',
    'SLA' => '1',
    'Service' => '1',
    'State' => '1',
    'TicketNumber' => '100',
    'Title' => '120',
    'Type' => '1'
  },
  'Description' => 'All open tickets, these tickets have already been worked on, but need a response',
  'Filter' => 'All',
  'Group' => '',
  'Limit' => '10',
  'Module' => 'Kernel::Output::HTML::DashboardTicketGeneric',
  'Permission' => 'ro',
  'Time' => 'Age',
  'Title' => 'Open Tickets / Need to be answered'
};
} }
1;
