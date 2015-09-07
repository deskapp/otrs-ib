# --
# Kernel/System/Sphinx.pm - Sphinx search engine routines
# Copyright (C) 2014 Informatyka Boguslawski sp. z o.o. sp.k., http://www.ib.pl/
# Based on DB.pm by OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::System::Sphinx;

use strict;
use warnings;

use DBI;

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {};
    bless( $Self, $Type );

    # check needed objects
    for my $Object (qw(ConfigObject LogObject TimeObject MainObject EncodeObject)) {
        $Self->{$Object} = $Param{$Object} || die "Got no $Object!";
    }

    # 0=off; 1=updates; 2=+selects; 3=+Connects;
    $Self->{Debug} = $Param{Debug} || 0;

    # get sphinx parameters
    $Self->{Config} = $Self->{ConfigObject}->Get('Ticket::SearchIndex::Sphinx');
    if ( !$Self->{Config} ) {
        $Self->{LogObject}->Log(
            Priority => 'error',
            Message  => "Sphinx enabled but no Ticket::SearchIndex::Sphinx parameters defined!",
        );
        return;
    }

    $Self->{SphinxHost} = $Self->{Config}->{host} || '127.0.0.1';
    $Self->{SphinxPort} = $Self->{Config}->{port} || 9306;
    $Self->{SphinxMaxMatches} = $Self->{Config}->{max_matches} || 1000;
    $Self->{SphinxRanker} = $Self->{Config}->{ranker} || 'none';
    $Self->{SphinxIndexName} = $Self->{Config}->{index_name} || 'article_search';
    $Self->{SphinxUpdateOnly} = (defined $Self->{Config}->{update_only}) ? $Self->{Config}->{update_only} : 1;

    # prepare Sphinx connection string (using Sphinx MySQL protocol interface);
    # persistent connections to Sphinx available using DBI
    my $DSN = 'DBI:mysql:host=' . $Self->{SphinxHost} . ';port=' . $Self->{SphinxPort};

    # DBI/DBD::mysql attributes
    # disable automatic reconnects as they do not execute "SET NAMES utf8", which will
    # cause charset problems
    my $Attribute = {
        mysql_auto_reconnect => 0,
    };

    # sphinx connect
    $Self->{sph} = DBI->connect(
        $DSN,
        '',
        '',
        $Attribute,
    );

    if ( !$Self->{sph} ) {
        $Self->{LogObject}->Log(
            Caller   => 1,
            Priority => 'Error',
            Message  => $DBI::errstr,
        );
        return;
    }

    $Self->Do( SphinxQL => 'SET NAMES utf8' );

    return $Self;
}

=item Do()

to insert, update or delete values

    $SphinxObject->Do( SphinxQL => "SELECT * FROM article_search WHERE MATCH('BOD*')" );

    you also can use DBI bind values (used for large strings):

    my $Var1 = 'dog1';
    my $Var2 = 'dog2';

    $SphinxObject->Do(
        SphinxQL  => "INSERT INTO index (name1, name2) VALUES (?, ?)",
        Bind => [ \$Var1, \$Var2 ],
    );

=cut

sub Do {
    my ( $Self, %Param ) = @_;

    # cancel if no sphinx connection available
    return if !$Self->{sph};

    # check needed stuff
    if ( !$Param{SphinxQL} ) {
        $Self->{LogObject}->Log( Priority => 'error', Message => 'Need SphinxQL!' );
        return;
    }

    # check bind params
    my @Array;
    if ( $Param{Bind} ) {
        for my $Data ( @{ $Param{Bind} } ) {
            if ( ref $Data eq 'SCALAR' ) {
                push @Array, $$Data;
            }
            else {
                $Self->{LogObject}->Log(
                    Caller   => 1,
                    Priority => 'Error',
                    Message  => 'No SCALAR param in Bind!',
                );
                return;
            }
        }
    }

    # Replace current_timestamp with real time stamp.
    # - This avoids time inconsistencies of app and db server
    my $Timestamp = $Self->{TimeObject}->CurrentTimestamp();
    $Param{SphinxQL} =~ s{
        (?<= \s | \( | , )  # lookahead
        current_timestamp   # replace current_timestamp by 'yyyy-mm-dd hh:mm:ss'
        (?=  \s | \) | , )  # lookbehind
    }
    {
        '$Timestamp'
    }xmsg;

    # Replace index_name with real index name from config.
    $Param{SphinxQL} =~ s{
        (?<= \s | \( | , )  # lookahead
        index_name
        (?=  \s | \) | , )  # lookbehind
    }
    { $Self->{SphinxIndexName} }xmsg;

    # debug
    if ( $Self->{Debug} > 0 ) {
        $Self->{DoCounter}++;
        $Self->{LogObject}->Log(
            Caller   => 1,
            Priority => 'debug',
            Message  => "Sphinx.pm->Do SphinxQL: '$Param{SphinxQL}'",
        );
    }

    # check length, don't use more than 4 k
    if ( bytes::length( $Param{SphinxQL} ) > 4 * 1024 ) {
        $Self->{LogObject}->Log(
            Caller   => 1,
            Priority => 'notice',
            Message  => 'Your SphinxQL is longer than 4k. Use bind instead! SphinxQL: '
                . $Param{SphinxQL},
        );
    }

    # send SphinxQL to sphinx
    if ( !$Self->{sph}->do( $Param{SphinxQL}, undef, @Array ) ) {
        $Self->{LogObject}->Log(
            Caller   => 1,
            Priority => 'error',
            Message  => "$DBI::errstr, SphinxQL: '$Param{SphinxQL}'",
        );
        return;
    }

    return 1;
}

=item Prepare()

to prepare a SELECT statement

    $SphinxObject->Prepare(
        SphinxQL   => "SELECT id, name FROM table",
        Limit => 10,
    );

or in case you want just to get row 10 until 30

    $SphinxObject->Prepare(
        SphinxQL   => "SELECT id, name FROM table",
        Start => 10,
        Limit => 20,
    );

in case you don't want utf-8 encoding for some columns, use this:

    $SphinxObject->Prepare(
        SphinxQL    => "SELECT id, name, content FROM table",
        Encode => [ 1, 1, 0 ],
    );

you also can use DBI bind values, required for large strings:

    my $Var1 = 'dog1';
    my $Var2 = 'dog2';

    $SphinxObject->Prepare(
        SphinxQL    => "SELECT id, name, content FROM table WHERE name_a = ? AND name_b = ?",
        Encode => [ 1, 1, 0 ],
        Bind   => [ \$Var1, \$Var2 ],
    );

=cut

sub Prepare {
    my ( $Self, %Param ) = @_;

    # cancel if no sphinx connection available
    return if !$Self->{sph};

    # check needed stuff
    if ( !$Param{SphinxQL} ) {
        $Self->{LogObject}->Log( Priority => 'error', Message => 'Need SQL!' );
        return;
    }

    my $SphinxQL = $Param{SphinxQL};
    my $Limit    = $Param{Limit} || '';
    my $Start    = $Param{Start} || '';


    # query limit must not be greater than Sphinx max_matches
    if ($Limit > $Self->{SphinxMaxMatches}) {
        $Limit = $Self->{SphinxMaxMatches};
    }

    if ( defined $Param{Encode} ) {
        $Self->{Encode} = $Param{Encode};
    }
    else {
        $Self->{Encode} = undef;
    }
    $Self->{Limit}        = 0;
    $Self->{LimitStart}   = 0;
    $Self->{LimitCounter} = 0;

    # build final select query
    if ($Limit) {
        if ($Start) {
            $Limit = $Limit + $Start;
            $Self->{LimitStart} = $Start;
        }
        $SphinxQL .= " LIMIT $Limit";
    }
    $SphinxQL .= ' OPTION ranker=' . $Self->{SphinxRanker}
        . ', max_matches=' . $Self->{SphinxMaxMatches};

    # Replace index_name with real index name from config.
    $SphinxQL =~ s{
        (?<= \s | \( | , )  # lookahead
        index_name
        (?=  \s | \) | , )  # lookbehind
    }
    { $Self->{SphinxIndexName} }xmsg;

    # debug
    if ( $Self->{Debug} > 1 ) {
        $Self->{PrepareCounter}++;
        $Self->{LogObject}->Log(
            Caller   => 1,
            Priority => 'debug',
            Message  => "Sphinx.pm->Prepare ($Self->{PrepareCounter}/" . time() . ") SphinxQL: '$SphinxQL'",
        );
    }

    # check bind params
    my @Array;
    if ( $Param{Bind} ) {
        for my $Data ( @{ $Param{Bind} } ) {
            if ( ref $Data eq 'SCALAR' ) {
                push @Array, $$Data;
            }
            else {
                $Self->{LogObject}->Log(
                    Caller   => 1,
                    Priority => 'Error',
                    Message  => 'No SCALAR param in Bind!',
                );
                return;
            }
        }
    }

    # do
    if ( !( $Self->{Cursor} = $Self->{sph}->prepare($SphinxQL) ) ) {
        $Self->{LogObject}->Log(
            Caller   => 1,
            Priority => 'Error',
            Message  => "$DBI::errstr, SphinxQL: '$SphinxQL'",
        );
        return;
    }

    if ( !$Self->{Cursor}->execute(@Array) ) {
        $Self->{LogObject}->Log(
            Caller   => 1,
            Priority => 'Error',
            Message  => "$DBI::errstr, SphinxQL: '$SphinxQL'",
        );
        return;
    }

    return 1;
}

=item FetchrowArray()

to process the results of a SELECT statement

    $SphinxObject->Prepare(
        SphinxQL   => "SELECT id, name FROM table",
        Limit => 10
    );

    while (my @Row = $SphinxObject->FetchrowArray()) {
        print "$Row[0]:$Row[1]\n";
    }

=cut

sub FetchrowArray {
    my $Self = shift;

    # cancel if no sphinx connection available
    return if !$Self->{sph};

    # fetch first not used rows
    if ( $Self->{LimitStart} ) {
        for ( 1 .. $Self->{LimitStart} ) {
            if ( !$Self->{Cursor}->fetchrow_array() ) {
                $Self->{LimitStart} = 0;
                return ();
            }
            $Self->{LimitCounter}++;
        }
        $Self->{LimitStart} = 0;
    }

    # return
    my @Row = $Self->{Cursor}->fetchrow_array();

    # e. g. set utf-8 flag
    my $Counter = 0;
    ELEMENT:
    for my $Element (@Row) {
        if ( !$Element ) {
            next ELEMENT;
        }

        if ( !defined $Self->{Encode} || ( $Self->{Encode} && $Self->{Encode}->[$Counter] ) ) {
            $Self->{EncodeObject}->EncodeInput( \$Element );
        }
    }
    continue {
        $Counter++;
    }

    return @Row;
}

# return current update_only setting
sub UpdateOnly {
    my $Self = shift;
    return $Self->{SphinxUpdateOnly};
}

1;
