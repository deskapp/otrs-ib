# --
# Copyright (C) 2016 Informatyka Boguslawski sp. z o.o. sp.k., http://www.ib.pl/
# Based on WebUploadCache.t by OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

use strict;
use warnings;
use utf8;

use vars (qw($Self));

use Digest::MD5 qw(md5_hex);

# get needed objects
my $ConfigObject = $Kernel::OM->Get('Kernel::Config');
my $EncodeObject = $Kernel::OM->Get('Kernel::System::Encode');
my $MainObject   = $Kernel::OM->Get('Kernel::System::Main');

# get command object
my $CommandObject = $Kernel::OM->Get('Kernel::System::Console::Command::Maint::WebUploadCache::Cleanup');

my ( $Result, $ExitCode );

my $Helper = $Kernel::OM->Get('Kernel::System::UnitTest::Helper');


for my $Module (qw(DB FS)) {

    # make sure that the $UploadCacheObject gets recreated for each loop.
    $Kernel::OM->ObjectsDiscard( Objects => ['Kernel::System::Web::UploadCache'] );

    $ConfigObject->Set(
        Key   => 'WebUploadCacheModule',
        Value => "Kernel::System::Web::UploadCache::$Module",
    );

    # get a new upload cache object
    my $UploadCacheObject = $Kernel::OM->Get('Kernel::System::Web::UploadCache');

    my $FormID = $UploadCacheObject->FormIDCreate();

    $Self->True(
        $FormID,
        "#$Module - FormIDCreate()",
    );

    my $Location = $ConfigObject->Get('Home')
        . "/scripts/test/sample/WebUploadCache/WebUploadCache-Test1.txt";

    my $ContentRef = $MainObject->FileRead(
        Location => $Location,
        Mode     => 'binmode',
    );
    my $Content = ${$ContentRef};
    $EncodeObject->EncodeOutput( \$Content );

    my $MD5         = md5_hex($Content);
    my $ContentID   = undef;
    my $Disposition = 'attachment';

    my $Add = $UploadCacheObject->FormIDAddFile(
        FormID      => $FormID,
        Filename    => 'UploadCache Test1äöüß.txt',
        Content     => $Content,
        ContentType => 'text/html',
        ContentID   => $ContentID,
        Disposition => $Disposition,
    );

    $Self->True(
        $Add || '',
        "#$Module - FormIDAddFile()",
    );

    # delete upload cache - should not remove cached form
    $ExitCode = $CommandObject->Execute();
    $Self->Is(
        $ExitCode,
        0,
        "#$Module - delete upload cache",
    );

    my @Data = $UploadCacheObject->FormIDGetAllFilesData(
        FormID => $FormID,
    );

    $Self->True(
        scalar @Data,
        "#$Module - FormIDGetAllFilesData() check if formid is present",
    );

    @Data = $UploadCacheObject->FormIDGetAllFilesMeta( FormID => $FormID );

    $Self->True(
        scalar @Data,
        "#$Module - FormIDGetAllFilesMeta() check if formid is present",
    );

    # set fixed time
    $Helper->FixedTimeSet();

    # wait 24h+1s to expire upload cache
    $Helper->FixedTimeAddSeconds(86401);

    # delete upload cache - should remove cached form
    $ExitCode = $CommandObject->Execute();
    $Self->Is(
        $ExitCode,
        0,
        "#$Module - delete upload cache",
    );

    @Data = $UploadCacheObject->FormIDGetAllFilesData(
        FormID => $FormID,
    );

    $Self->False(
         scalar @Data,
        "#$Module - FormIDGetAllFilesData() check if formid is absent",
    );

    @Data = $UploadCacheObject->FormIDGetAllFilesMeta(
        FormID => $FormID,
    );

    $Self->False(
         scalar @Data,
        "#$Module - FormIDGetAllFilesMeta() check if formid is absent",
    );

    # unset fixed time
    $Helper->FixedTimeUnset();

}

1;
