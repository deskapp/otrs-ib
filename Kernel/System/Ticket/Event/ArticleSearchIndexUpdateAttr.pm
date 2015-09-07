# --
# Kernel/System/Ticket/Event/ArticleSearchIndexUpdateAttr.pm - update article search index attributes
# Copyright (C) 2014 Informatyka Boguslawski sp. z o.o. sp.k., http://www.ib.pl/
# Based on ArticleSearchIndex.pm by OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::System::Ticket::Event::ArticleSearchIndexUpdateAttr;

use strict;
use warnings;

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {};
    bless( $Self, $Type );

    # get needed objects
    for (
        qw(ConfigObject TicketObject LogObject UserObject CustomerUserObject SendmailObject TimeObject EncodeObject)
        )
    {
        $Self->{$_} = $Param{$_} || die "Got no $_!";
    }

    return $Self;
}

sub Run {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for (qw(Data Event Config)) {
        if ( !$Param{$_} ) {
            $Self->{LogObject}->Log( Priority => 'error', Message => "Need $_!" );
            return;
        }
    }
    for (qw(TicketID)) {
        if ( !$Param{Data}->{$_} ) {
            $Self->{LogObject}->Log( Priority => 'error', Message => "Need $_ in Data!" );
            return;
        }
    }

    $Self->{TicketObject}->ArticleIndexUpdateAttr(
        TicketID => $Param{Data}->{TicketID},
        UserID    => 1,
    );

    return 1;
}

1;
