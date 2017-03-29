# --
# Kernel/System/Ticket/ArticleSearchIndex/SphinxAndStaticDB.pm - article search index backend static with Sphinx support
# Copyright (C) 2014-2017 Informatyka Boguslawski sp. z o.o. sp.k., http://www.ib.pl/
# Based on StaticDB.pm by OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::System::Ticket::ArticleSearchIndex::SphinxAndStaticDB;

use strict;
use warnings;

use Kernel::System::Sphinx;

our @ObjectDependencies = (
    'Kernel::System::Log',
    'Kernel::System::Main',
    'Kernel::System::Queue',
);

sub new {
    my ( $Class, %Param ) = @_;

    $Kernel::OM->Get('Kernel::System::Main')->RequireBaseClass('Kernel::System::Ticket::ArticleSearchIndex::StaticDB')
        || die 'Could not load Kernel::System::Ticket::ArticleSearchIndex::StaticDB';

    my $Self = $Class->SUPER::new(%Param);

    $Self->{SphinxObject} = Kernel::System::Sphinx->new(%Param);

    # save sphinx update only mode status
    $Self->{UpdateOnly} = 1;
    if ($Self->{SphinxObject}) {
        $Self->{UpdateOnly} = $Self->{SphinxObject}->UpdateOnly();
    }

    return $Self;
}

sub ArticleIndexBuild {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Needed (qw(ArticleID UserID)) {
        if ( !$Param{$Needed} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log( Priority => 'error', Message => "Need $Needed!" );
            return;
        }
    }

    # skip rebuilding parent index if requested; for faster
    # Sphinx index creation/rebuilding in UpdateOnly mode
    if (!$Param{MainIndexOnly}) {
        return if !$Self->SUPER::ArticleIndexBuild(%Param);
    }

    if ($Self->{SphinxObject}) {

        my %Article = $Kernel::OM->Get('Kernel::System::Ticket::Article')->ArticleGet(
            ArticleID     => $Param{ArticleID},
            UserID        => $Param{UserID},
            DynamicFields => 0,
        );

        if (%Article) {
            # sphinxql does not accept NULL values; replace NULLs with empty string
            for (qw(From To Cc Subject MessageID Body)) {
                if ( !defined($Article{$_}) ) {
                    $Article{$_} = '';
                }
            }

            # feed content to sphinx
            my $ArchiveFlag = ($Article{ArchiveFlag} && $Article{ArchiveFlag} eq 'y') ? 1 : 0;
            $Self->{SphinxObject}->Do(
                SphinxQL => 'REPLACE INTO index_name (id, ticket_id, queue_id, archive_flag,
                    a_from, a_to, a_cc, a_subject, a_message_id, a_body)
                    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
                Bind => [
                    \$Article{ArticleID}, \$Article{TicketID},  \$Article{QueueID}, \$ArchiveFlag,
                    \$Article{From},      \$Article{To},        \$Article{Cc},
                    \$Article{Subject},   \$Article{MessageID}, \$Article{Body},
                ],
            );
        }
    }

    return 1;
}

sub ArticleIndexDelete {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Needed (qw(ArticleID UserID)) {
        if ( !$Param{$Needed} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log( Priority => 'error', Message => "Need $Needed!" );
            return;
        }
    }

    return if !$Self->SUPER::ArticleIndexDelete(%Param);

    if ($Self->{SphinxObject}) {
        # delete article
        $Self->{SphinxObject}->Do(
            SphinxQL  => 'DELETE FROM index_name WHERE id = ' . $Param{ArticleID},
        );
    }

    return 1;
}

sub ArticleIndexDeleteTicket {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Needed (qw(TicketID UserID)) {
        if ( !$Param{$Needed} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log( Priority => 'error', Message => "Need $Needed!" );
            return;
        }
    }

    return if !$Self->SUPER::ArticleIndexDeleteTicket(%Param);

    if ($Self->{SphinxObject}) {

        # we need to delete articles in loop because Sphinx doesn't support attributes
        # in delete's where condition and may not return all matching articles in one
        # query
        my $RecordsFound;
        do {
            $RecordsFound = 0;

            # get article ids (limit to 100 articles per one search)
            my $Result = $Self->{SphinxObject}->Prepare(
                SphinxQL => 'SELECT id FROM index_name WHERE ticket_id = '
                    . $Param{TicketID},
                Limit => 100,
            );

            if ($Result) {
                # fetch the result
                my @ResponseData;

                while ( my @Row = $Self->{SphinxObject}->FetchrowArray() ) {
                    push( @ResponseData, $Row[0] );
                    $RecordsFound = 1;
                }

                # delete articles if found
                if ($RecordsFound) {
                    # delete articles
                    $Self->{SphinxObject}->Do(
                        SphinxQL  => 'DELETE FROM index_name WHERE id in ('
                            . join(', ', @ResponseData) . ')' ,
                    );
                }
            }
        } until ($RecordsFound == 0);
    }

    return 1;
}

sub ArticleIndexMergeTicket {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Needed (qw(MainTicketID MergeTicketID UserID)) {
        if ( !$Param{$Needed} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log( Priority => 'error', Message => "Need $Needed!" );
            return;
        }
    }

    return if !$Self->SUPER::ArticleIndexMergeTicket(%Param);

    if ($Self->{SphinxObject}) {
        # update ticket id in merged articles
        $Self->{SphinxObject}->Do(
            SphinxQL  => 'UPDATE index_name SET ticket_id='
                . $Param{MainTicketID} . ' WHERE ticket_id=' . $Param{MergeTicketID},
        );
    }

    return 1;
}

sub _ArticleIndexQuerySQL {
    my ( $Self, %Param ) = @_;

    if ( !$Param{Data} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log( Priority => 'error', Message => "Need Data!" );
        return;
    }

    # use parent module if sphinx not available OR not fired from toolbar
    # OR in update only mode
    if ( (!$Self->{SphinxObject})
        || (!$Param{Data}->{FulltextToolBarSearch})
        || $Self->{UpdateOnly} ) {
        return $Self->SUPER::_ArticleIndexQuerySQL(%Param);
    }

    # no article_table SQL join required if querying sphinx
    return ' ';
}

sub _ArticleIndexQuerySQLExt {
    my ( $Self, %Param ) = @_;

    if ( !$Param{Data} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log( Priority => 'error', Message => "Need Data!" );
        return;
    }

    # use parent module if sphinx not available OR not fired from toolbar
    # OR in update only mode
    if ( (!$Self->{SphinxObject})
        || (!$Param{Data}->{FulltextToolBarSearch})
        || $Self->{UpdateOnly} ) {
        return $Self->SUPER::_ArticleIndexQuerySQLExt(%Param);
    }

    # sphinx searching mode; group by ticket_id in sphinx returns only one document
    # with distinct ticket_id so we will use it instead of "select distinct(ticket_id)..."
    # construct which is unavailable in sphinx
    my $Result = ' AND 1=0 ';

    # build queue access condition for non-admin users
    my $QueueCondition = '';
    if ( $Param{Data}->{UserID} && $Param{Data}->{UserID} != 1 ) {
        # get list of all queues user that has ro access to
        my %Queues = $Kernel::OM->Get('Kernel::System::Queue')->GetAllQueues(
            UserID => $Param{Data}->{UserID},
            Type => 'ro',
        );

        # return empty result if no permitted queues exist
        return $Result if !%Queues;

        $QueueCondition = " AND queue_id IN (${\(join ', ' , sort {$a <=> $b} keys %Queues)})";
    }

    # build archive state condition if defined
    my $ArchiveCondition = (defined $Param{Data}->{ArchiveFlag})
        ? ' AND archive_flag = ' . $Param{Data}->{ArchiveFlag} : '';

    # disable some sphinx operators (replace with space in search term)
    # to avoid sphinx errors in case it appears in search terms
    # (i.e. e-mail address or path specifications)
    $Param{Data}->{Fulltext} =~ s/[@\/!]/ /g;

    my $PrepareResult = $Self->{SphinxObject}->Prepare(
        SphinxQL => 'SELECT ticket_id FROM index_name WHERE MATCH(?) '
            . $QueueCondition . $ArchiveCondition
            . ' GROUP BY ticket_id ORDER BY ticket_id DESC',
        Bind => [ \$Param{Data}->{Fulltext} ],
        Limit => $Param{Data}->{Limit},
    );

    if ($PrepareResult) {
        # prepare sphinx based where condition with ticket id found
        my @ResponseData;
        my $RecordsFound;
        while ( my @Row = $Self->{SphinxObject}->FetchrowArray() ) {
            push( @ResponseData, $Row[0] );
            $RecordsFound = 1;
        }
        if ($RecordsFound) {
            $Result = ' AND st.id in (' . join(', ', @ResponseData) . ')' ,
        }
    }

    return $Result;
}

# update index attributes (queue_id, achive_flag) aftger ticket changes
sub ArticleIndexUpdateAttr {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Needed (qw(TicketID UserID)) {
        if ( !$Param{$Needed} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log( Priority => 'error', Message => "Need $Needed!" );
            return;
        }
    }

    return if !$Self->SUPER::ArticleIndexUpdateAttr(%Param);

    if ($Self->{SphinxObject}) {

        my %Ticket = $Self->TicketGet(
            TicketID      => $Param{TicketID},
            UserID        => $Param{UserID},
            DynamicFields => 0,
        );

        if (%Ticket) {
            # update search index attributes
            my $ArchiveFlag = ($Ticket{ArchiveFlag} && $Ticket{ArchiveFlag} eq 'y') ? 1 : 0;
            $Self->{SphinxObject}->Do(
                SphinxQL => 'UPDATE index_name SET queue_id = ' . $Ticket{QueueID}
                    . ', archive_flag = ' . $ArchiveFlag
                    . ' WHERE ticket_id = ' . $Param{TicketID},
            );
        }
    }

    return 1;
}

1;
