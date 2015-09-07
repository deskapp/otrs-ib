# --
# Kernel/Output/HTML/OutputFilterTextURL.pm - auto URL detection filter
# Copyright (C) 2001-2014 OTRS AG, http://otrs.com/
# Copyright (C) 2013 Informatyka Boguslawski sp. z o.o. sp.k., http://www.ib.pl/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::Output::HTML::OutputFilterTextURL;

use strict;
use warnings;

use vars qw(@ISA);

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {};
    bless( $Self, $Type );

    # check needed objects
    for (qw(DBObject ConfigObject LogObject TimeObject MainObject LayoutObject)) {
        $Self->{$_} = $Param{$_} || die "Got no $_!";
    }

    return $Self;
}

sub Pre {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    if ( !defined $Param{Data} ) {
        $Self->{LogObject}->Log( Priority => 'error', Message => 'Need Data!' );
        $Self->{LayoutObject}->FatalDie();
    }

    $Self->{LinkHash} = undef;
    my $Counter = 0;


    if ( $Self->{ConfigObject}->Get('FindURIEnabled')
            && $Self->{MainObject}->Require('URI::Find::Schemeless') ) {

        # new way if URI::Find::Schemeless available

        require Kernel::System::FindURI;

        my $finder = Kernel::System::FindURI->new(sub {
            my($uri, $orig_uri) = @_;

            $Counter++;
            $Self->{LinkHash}->{"$Counter"} = {orig_uri => $orig_uri, uri => $uri};
            return qq|############LinkHash-$Counter############|;
        });

        $finder->find(\${$Param{Data}});

    } else {

        # old OTRS way

        ${ $Param{Data} } =~ s{
            ( > | < | &gt; | &lt; | )  # $1 greater-than and less-than sign

            (                                              #2
                (?:                                      # http or only www
                    (?: (?: http s? | ftp ) :\/\/) |        # http://,https:// and ftp://
                    (?: (?: \w*www | ftp ) \. \w+ )                 # www.something and ftp.something
                )
                .*?               # this part should be better defined!
            )
            (                               # $3
                [\?,;!\.\)\]] (?: \s | $ )    # \)\s this construct is because of bug#2450 and bug#7288
                | \s
                | \"
                | &quot;
                | &nbsp;
                | '
                | >                           # greater-than and less-than sign
                | <                           # "
                | &gt;                        # "
                | &lt;                        # "
                | $                           # bug# 2715
            )        }
        {
            my $Start = $1;
            my $Link  = $2;
            my $End   = $3;
            $Counter++;
            my $orig_uri = $Link;
            if ( $Link !~ m{^ ( http | https | ftp ) : \/ \/ }xi ) {
                if ($Link =~ m{^ ftp }smx ) {
                    $Link = 'ftp://' . $Link;
                }
                else {
                    $Link = 'http://' . $Link;
                }
            }
            $Self->{LinkHash}->{"$Counter"} = {orig_uri => $orig_uri, uri => $Link};
            $Start . "############LinkHash-$Counter############" . $End;
        }egxism;

    }

    return $Param{Data};
}

sub Post {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    if ( !defined $Param{Data} ) {
        $Self->{LogObject}->Log( Priority => 'error', Message => 'Need Data!' );
        $Self->{LayoutObject}->FatalDie();
    }

    if ( $Self->{LinkHash} ) {
        for my $Key ( sort keys %{ $Self->{LinkHash} } ) {
            my $LinkSmall = $Self->{LinkHash}->{$Key}->{orig_uri};
            $LinkSmall =~ s/^(.{75}).*$/$1\[\.\.\]/gs;
            ${ $Param{Data} }
                =~ s/\Q############LinkHash-$Key############\E/<a href=\"$Self->{LinkHash}->{$Key}->{uri}\" target=\"_blank\" title=\"$Self->{LinkHash}->{$Key}->{uri}\">$LinkSmall<\/a>/;
        }
    }

    return $Param{Data};
}

1;
