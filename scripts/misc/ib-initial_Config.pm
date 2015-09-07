# --
# Kernel/Config.pm - Config file for OTRS kernel
# Copyright (C) 2001-2013 OTRS AG, http://otrs.org/
# Copyright (C) 2013-2014 Informatyka Boguslawski sp. z o.o. sp.k., http://www.ib.pl/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --
#  Note:
#
#  -->> Most OTRS configuration should be done via the OTRS web interface
#       and the SysConfig. Only for some configuration, such as database
#       credentials and customer data source changes, you should edit this
#       file. For changes do customer data sources you can copy the definitions
#       from Kernel/Config/Defaults.pm and paste them in this file.
#       Config.pm will not be overwritten when updating OTRS.
# --

package Kernel::Config;

use strict;
use warnings;
use utf8;

sub Load {
    my $Self = shift;

    # ---------------------------------------------------- #
    # database settings                                    #
    # ---------------------------------------------------- #

    # The database host
    $Self->{'DatabaseHost'} = 'localhost';

    # The database name
    $Self->{'Database'} = 'otrs';

    # The database user
    $Self->{'DatabaseUser'} = 'otrs';

    # The password of database user. You also can use bin/otrs.CryptPassword.pl
    # for crypted passwords
    $Self->{'DatabasePw'} = 'password';

    # The database DSN for MySQL ==> more: "perldoc DBD::mysql"
    $Self->{'DatabaseDSN'} = "DBI:mysql:database=$Self->{Database};host=$Self->{DatabaseHost}";

    # ---------------------------------------------------- #
    # fs root directory
    # ---------------------------------------------------- #
    $Self->{Home} = '/opt/otrs';

    # ---------------------------------------------------- #
    # insert your own config settings "here"               #
    # config settings taken from Kernel/Config/Defaults.pm #
    # ---------------------------------------------------- #
    $Self->{'LogoutURL'} = '';
    $Self->{'LoginURL'} = '';
    $Self->{'LogModule'} = 'Kernel::System::Log::SysLog';
    $Self->{'LogModule::LogFile'} = '/var/opt/otrs/file/log/otrs.log';
    $Self->{'ArticleDir'} = '/var/opt/otrs/file/article';
    $Self->{'Ticket::StorageModule'} = 'Kernel::System::Ticket::ArticleStorageFS';
    $Self->{'Ticket::CounterLog'} = '/var/opt/otrs/file/counter/TicketCounter.log';
    $Self->{'TempDir'} = '/var/opt/otrs/tmp';
    $Self->{'Ticket::NumberGenerator::MinCounterSize'} = '7';
    $Self->{'Ticket::NumberGenerator'} = 'Kernel::System::Ticket::Number::AutoIncrement';
    $Self->{'Ticket::Hook'} = 'TICKET#';
    $Self->{'NotificationSenderEmail'} = 'help@change.me';
    $Self->{'NotificationSenderName'} = 'Company Name Helpdesk';
    $Self->{'LostPassword'} =  '0';
    $Self->{'WebUploadCacheModule'} =  'Kernel::System::Web::UploadCache::FS';
    $Self->{'WebMaxFileUpload'} =  '20971520';
    $Self->{'SessionCheckRemoteIP'} =  0;
    $Self->{'SendmailEncodingForce'} =  'quoted-printable';
    $Self->{'SendmailModule'} =  'Kernel::System::Email::SMTP';
    $Self->{'SendmailModule::Host'} =  '127.0.0.1';
    $Self->{'SendmailModule::Port'} =  '25';
    $Self->{'DefaultLanguage'} =  'pl';
    $Self->{'Organization'} =  'Company Name';
    $Self->{'AdminEmail'} =  'help@change.me';
    $Self->{'HttpType'} =  'https';
    $Self->{'FQDN'} =  'helpdesk.change.me';
    $Self->{'SystemID'} =  '1';
    $Self->{'ProductName'} =  'Company Name Helpdesk';
    $Self->{'SecureMode'} =  '1';
    $Self->{'CustomerHeadline'} =  'Company Name Helpdesk';
    $Self->{'CustomerPanelCreateAccount'} =  '0';
    $Self->{'CustomerPanelLostPassword'} =  '0';
    $Self->{'Frontend::RichText::DefaultCSS'} =  'font-family: Verdana, \'Bitstream Vera Sans\', \'DejaVu Sans\', Tahoma, Geneva, Arial, Sans-serif; font-size: 10pt; color: #000000;';
    $Self->{'CustomerGroupSupport'} =  1;
    $Self->{'AuthModule::DB::CryptType'} = 'bcrypt';
    $Self->{'AuthModule::DB::bcryptCost'} = 12;
    $Self->{'Customer::AuthModule::DB::CryptType'} = 'bcrypt';
    $Self->{'Customer::AuthModule::DB::bcryptCost'} = 12;

    # disable unnecessary features 
    delete $Self->{'PreferencesGroups'}->{'SpellDict'};

    # remove insecure packages from admin panel
#    delete $Self->{'Frontend::Module'}->{'AdminPackageManager'};
    delete $Self->{'Frontend::Module'}->{'AdminSelectBox'};
#    delete $Self->{'Frontend::Module'}->{'AdminPerformanceLog'};
#    delete $Self->{'Frontend::Module'}->{'AdminLog'};
#    delete $Self->{'Frontend::Module'}->{'AdminSysConfig'};
#    delete $Self->{'Frontend::Module'}->{'AdminGenericAgent'};
#    delete $Self->{'Frontend::Module'}->{'AdminMailAccount'};

    # If HTTPBasicAuth AuthModule is being used, set LoginURL to page that will
    # be displayed when user won't be authenticated using HTTPBasicAuth and set
    # LogoutURL to page that will be displayed after user presses logout button.
#    $Self->{'AuthModule'} = 'Kernel::System::Auth::HTTPBasicAuth';
#    $Self->{'LoginURL'} = '/otrs-web/agent-not-authorised.html';
#    $Self->{'LogoutURL'} = '/otrs-web/agent-logged-out.html';

    # In case you need to replace some part of the REMOTE_USER, you can
    # use the following RegExp ($1 will be new login).
#    $Self->{'AuthModule::HTTPBasicAuth::ReplaceRegExp'} = '^(.+?)@.+?$';

    # If HTTPBasicAuth Customer::AuthModule is being used, set CustomerPanelLoginURL
    # to page that will be displayed when user won't be authenticated using HTTPBasicAuth
    # and set CustomerPanelLogoutURL to page that will be displayed after user presses
    # logout button.
#    $Self->{'Customer::AuthModule'} = 'Kernel::System::CustomerAuth::HTTPBasicAuth';
#    $Self->{'CustomerPanelLoginURL'} = '/otrs-web/customer-not-authorised.html';
#    $Self->{'CustomerPanelLogoutURL'} = '/otrs-web/customer-logged-out.html';

    # In case you need to replace some part of the REMOTE_USER, you can
    # use the following RegExp ($1 will be new login).
#    $Self->{'Customer::AuthModule::HTTPBasicAuth::ReplaceRegExp'} = '^(.+?)@.+?$';

    # ---------------------------------------------------- #

    # ---------------------------------------------------- #
    # data inserted by installer                           #
    # ---------------------------------------------------- #
    # $DIBI$

    # ---------------------------------------------------- #
    # ---------------------------------------------------- #
    #                                                      #
    # end of your own config options!!!                    #
    #                                                      #
    # ---------------------------------------------------- #
    # ---------------------------------------------------- #
}

# ---------------------------------------------------- #
# needed system stuff (don't edit this)                #
# ---------------------------------------------------- #
use strict;
use warnings;

use vars qw(@ISA);

use Kernel::Config::Defaults;
push (@ISA, 'Kernel::Config::Defaults');

# -----------------------------------------------------#

1;
