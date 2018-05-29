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

local $ENV{SCRIPT_NAME} = 'index.pl';

# get needed objects
$Kernel::OM->ObjectParamAdd(
    'Kernel::System::UnitTest::Helper' => {
        RestoreDatabase => 1,
    },
);
my $Helper = $Kernel::OM->Get('Kernel::System::UnitTest::Helper');

$Kernel::OM->ObjectParamAdd(
    'Kernel::Output::HTML::Layout' => {
        Lang      => 'de',
        SessionID => 123,
    },
);
my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');

my @Tests = (
    {
        Name => '',
        Data => {
            Content     => '<img src="cid:1234567890ABCDEF">',
            ContentType => 'text/html; charset="iso-8859-1"',
        },
        URL         => 'Action=SomeAction;FileID=',
        Attachments => {
            0 =>
                {
                ContentID => '<1234567890ABCDEF>',
                },
        },
        Result => {
            Content =>
                '<img src="index.pl?Action=SomeAction;FileID=0;SessionID=123">',
            ContentType => 'text/html; charset="utf-8"',
        },
    },
    {
        Name => '',
        Data => {
            Content     => "<img border=\"0\" src=\"cid:1234567890ABCDEF\">",
            ContentType => 'text/html; charset="iso-8859-1"',
        },
        URL         => 'Action=SomeAction;FileID=',
        Attachments => {
            0 =>
                {
                ContentID => '<1234567890ABCDEF>',
                },
        },
        Result => {
            Content =>
                '<img border="0" src="index.pl?Action=SomeAction;FileID=0;SessionID=123">',
            ContentType => 'text/html; charset="utf-8"',
        },
    },
    {
        Name => '',
        Data => {
            Content     => "<img border=\"0\" \nsrc=\"cid:1234567890ABCDEF\">",
            ContentType => 'text/html; charset="iso-8859-1"',
        },
        URL         => 'Action=SomeAction;FileID=',
        Attachments => {
            0 =>
                {
                ContentID => '<1234567890ABCDEF>',
                },
        },
        Result => {
            Content =>
                "<img border=\"0\" \nsrc=\"index.pl?Action=SomeAction;FileID=0;SessionID=123\">",
            ContentType => 'text/html; charset="utf-8"',
        },
    },
    {
        Name => '',
        Data => {
            Content     => '<img src=cid:1234567890ABCDEF>',
            ContentType => 'text/html; charset="iso-8859-1"',
        },
        URL         => 'Action=SomeAction;FileID=',
        Attachments => {
            0 =>
                {
                ContentID => '<1234567890ABCDEF>',
                },
        },
        Result => {
            Content =>
                '<img src="index.pl?Action=SomeAction;FileID=0;SessionID=123">',
            ContentType => 'text/html; charset="utf-8"',
        },
    },
    {
        Name => '',
        Data => {
            Content     => '<img src=cid:1234567890ABCDEF />',
            ContentType => 'text/html; charset="iso-8859-1"',
        },
        URL         => 'Action=SomeAction;FileID=',
        Attachments => {
            0 =>
                {
                ContentID => '<1234567890ABCDEF>',
                },
        },
        Result => {
            Content =>
                '<img src="index.pl?Action=SomeAction;FileID=0;SessionID=123" />',
            ContentType => 'text/html; charset="utf-8"',
        },
    },
    {
        Name => '',
        Data => {
            Content     => '<img src=\'cid:1234567890ABCDEF\' />',
            ContentType => 'text/html; charset="iso-8859-1"',
        },
        URL         => 'Action=SomeAction;FileID=',
        Attachments => {
            0 =>
                {
                ContentID => '<1234567890ABCDEF>',
                },
        },
        Result => {
            Content =>
                '<img src=\'index.pl?Action=SomeAction;FileID=0;SessionID=123\' />',
            ContentType => 'text/html; charset="utf-8"',
        },
    },
    {
        Name => '',
        Data => {
            Content     => '<img src=\'Untitled%20Attachment\' />',
            ContentType => 'text/html; charset="iso-8859-1"',
        },
        URL         => 'Action=SomeAction;FileID=',
        Attachments => {
            0 =>
                {
                ContentID => '<Untitled%20Attachment>',
                },
        },
        Result => {
            Content =>
                '<img src=\'index.pl?Action=SomeAction;FileID=0;SessionID=123\' />',
            ContentType => 'text/html; charset="utf-8"',
        },
    },
    {
        Name => 'drop script tag',
        Data => {
            Content     => '1<script></script>',
            ContentType => 'text/html; charset="iso-8859-1"',
        },
        URL         => 'Action=SomeAction;FileID=',
        Attachments => {
            0 => {
                ContentID => '<Untitled%20Attachment>',
            },
        },
        Result => {
            Content     => '1',
            ContentType => 'text/html; charset="utf-8"',
        },
    },
    {
        Name => 'keep script tag',
        Data => {
            Content     => '1<script></script>',
            ContentType => 'text/html; charset="iso-8859-1"',
        },
        URL         => 'Action=SomeAction;FileID=',
        Attachments => {
            0 => {
                ContentID => '<Untitled%20Attachment>',
            },
        },
        LoadInlineContent => 1,
        Result            => {
            Content     => '1<script></script>',
            ContentType => 'text/html; charset="utf-8"',
        },
    },
    {
        Name => 'drop external image',
        Data => {
            Content     => '1<img src="http://google.com"/>',
            ContentType => 'text/html; charset="iso-8859-1"',
        },
        URL         => 'Action=SomeAction;FileID=',
        Attachments => {
            0 => {
                ContentID => '<Untitled%20Attachment>',
            },
        },
        Result => {
            Content => '

<div style="margin: 5px 0; padding: 0px; border: 1px solid #999; border-radius: 2px; -moz-border-radius: 2px; -webkit-border-radius: 2px;">
    <div style="padding: 5px; background-color: #DDD; font-family:Geneva,Helvetica,Arial,sans-serif; font-size: 11px; text-align: center;">
        Zum Schutz Ihrer Privatsphäre wurden entfernte Inhalte blockiert.
        <a href="index.pl?;LoadExternalContent=1;SessionID=123">Blockierte Inhalte laden.</a>
    </div>
</div>
1',
            ContentType => 'text/html; charset="utf-8"',
        },
    },
    {
        Name => 'keep external image',
        Data => {
            Content     => '1<img src="http://google.com"/>',
            ContentType => 'text/html; charset="iso-8859-1"',
        },
        URL         => 'Action=SomeAction;FileID=',
        Attachments => {
            0 => {
                ContentID => '<Untitled%20Attachment>',
            },
        },
        LoadExternalContent => 1,
        Result             => {
            Content     => '1<img src="http://google.com"/>',
            ContentType => 'text/html; charset="utf-8"',
        },
    },
    {
        Name => 'transform content charset',
        Data => {
            Content => <<EOF,
<!DOCTYPE html SYSTEM "about:legacy-compat">
<html lang="de-de">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>
    <p>Some note about UTF8, UTF-8, utf8 and utf-8.</p>
    <p>Some note about ISO-8859-1 and iso-8859-1.</p>
    <p>This line must stay unchanged: charset=iso-8859-1</p>
</body>
</html>
EOF
            ContentType => 'text/html; charset="iso-8859-1"',
        },
        URL         => 'Action=SomeAction;FileID=',
        Attachments => {
            0 => {
                ContentID => '<Untitled%20Attachment>',
            },
        },
        LoadExternalContent => 1,
        Result             => {
            Content => <<EOF,
<!DOCTYPE html SYSTEM "about:legacy-compat">
<html lang="de-de">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body>
    <p>Some note about UTF8, UTF-8, utf8 and utf-8.</p>
    <p>Some note about ISO-8859-1 and iso-8859-1.</p>
    <p>This line must stay unchanged: charset=iso-8859-1</p>
</body>
</html>
EOF
            ContentType => 'text/html; charset="utf-8"',
        },
    },
    {
        Name => 'Standard ',
        Data => {
            Content     => 'Some Content',
            ContentType => 'text/html; charset="us-ascii"',
        },
        Attachments => {},
        URL         => 'Action=SomeAction;FileID=',
        Result      => {
            Content     => 'Some Content',
            ContentType => 'text/html; charset="utf-8"',
        },
    },
    {
        Name => 'Standard - no charset defined, see bug#9610',
        Data => {
            Content     => 'Some Content',
            ContentType => 'text/html',
        },
        Attachments => {},
        URL         => 'Action=SomeAction;FileID=',
        Result      => {
            Content     => 'Some Content',
            ContentType => 'text/html; charset="utf-8"',
        },
    },
    {
        Name => 'Empty Content-ID',
        Data => {
            Content     => 'Link <a href="http://test.example">http://test.example</a>',
            ContentType => 'text/html; charset="iso-8859-1"',
        },
        URL         => 'Action=SomeAction;FileID=',
        Attachments => {
            0 => {
                ContentID => '<>',
            },
        },
        LoadExternalContent => 1,
        Result             => {
            Content     => 'Link <a href="http://test.example" target="_blank">http://test.example</a>',
            ContentType => 'text/html; charset="utf-8"',
        },
    },
    {
        Name => 'Standard - extra spaces after charset and = tokens',
        Data => {
            Content     => 'Some Content',
            ContentType => 'text/html; charset = "utf-8"',
        },
        Attachments => {},
        URL         => 'Action=SomeAction;FileID=',
        Result      => {
            Content     => 'Some Content',
            ContentType => 'text/html; charset = "utf-8"',
        },
    },
);

for my $Test (@Tests) {
    my %HTML = $LayoutObject->RichTextDocumentServe(
        %{$Test},
    );
    $Self->Is(
        $HTML{Content},
        $Test->{Result}->{Content},
        "$Test->{Name} - Content",
    );
    $Self->Is(
        $HTML{ContentType},
        $Test->{Result}->{ContentType},
        "$Test->{Name} - ContentType",
    );
}

# cleanup cache is done by RestoreDatabase

1;
