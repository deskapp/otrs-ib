# --
# Kernel/System/Ticket/Event/ArticleSearchIndexUpdateAttr.pm - update article search index attributes
# Copyright (C) 2014-2015 Informatyka Boguslawski sp. z o.o. sp.k., http://www.ib.pl/
# Based on ArticleSearchIndex.pm by OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::System::Ticket::Event::ArticleSearchIndexUpdateAttr;

use strict;
use warnings;

our @ObjectDependencies = (
    'Kernel::System::Log',
    'Kernel::System::Ticket',
);

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {};
    bless( $Self, $Type );

    return $Self;
}

sub Run {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for (qw(Data Event Config)) {
        if ( !$Param{$_} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log( Priority => 'error', Message => "Need $_!" );
            return;
        }
    }
    for (qw(TicketID)) {
        if ( !$Param{Data}->{$_} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log( Priority => 'error', Message => "Need $_ in Data!" );
            return;
        }
    }

    $Kernel::OM->Get('Kernel::System::Ticket::Article')->ArticleIndexUpdateAttr(
        TicketID => $Param{Data}->{TicketID},
        UserID => 1,
    );

    return 1;
}

1;
