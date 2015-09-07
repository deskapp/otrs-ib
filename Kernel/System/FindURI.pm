# --
# Kernel/System/FindURI.pm - URI finder module for OTRS
# Copyright (C) 2011-2012 Informatyka Boguslawski sp. z o.o. sp.k., http://www.ib.pl/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::System::FindURI;

use strict;
use base qw(URI::Find::Schemeless);

# base.pm error in 5.005_03 prevents it from loading URI::Find::Schemeless if I'm
# required first.
use URI::Find::Schemeless ();

use vars qw($VERSION);
$VERSION = 20121117;


my($dnsSet) = 'a-z0-9-';

my($cruftSet) = __PACKAGE__->cruft_set . '<>?}';

my($tldRe) = __PACKAGE__->top_level_domain_re;

my($uricSet) = __PACKAGE__->uric_set;


=head1 NAME

Kernel::System::FindURI - Find schemeless URIs in arbitrary text.


=head1 SYNOPSIS

  require Kernel::System::FindURI;

  my $finder = Kernel::System::FindURI->new(\&callback);

  The rest is the same as URI::Find::Schemeless.


=head1 DESCRIPTION

Kernel::System::FindURI works just like URI::Find::Schemeless but acccepts
.pm and .pl TLDs and requires URI to start with www or ftp. Not accepting
IP addresses without schema. All case insensitive.

=cut

sub schemeless_uri_re {
    @_ == 1 || __PACKAGE__->badinvo;
    return qr{
              # same like in URI::Find::Schemeless but must begin
              # with www or ftp and .pm and .pl are allowed
              (?: ^ | (?<=[\s<>()\{\}\[\]]) )
              # hostname starting with www or http
              (?: (?:www|ftp)(?:\.[$dnsSet]+)*\.$tldRe)
              (?:
                  (?=[\s\Q$cruftSet\E]) # followed by unrelated thing
                  (?!\.\w)              #   but don't stop mid foo.xx.bar
                  |$                    # or end of line
                  |/[$uricSet#]*        # or slash and URI chars
              )
           }xi;
}

=head1 AUTHOR

Informatyka Boguslawski sp. z o.o. sp.k., http://www.ib.pl/
Based on URI::Find::Schemeless by Roderick Schertler <roderick@argon.org>,
adapted by Michael G Schwern <schwern@pobox.com>.

=head1 SEE ALSO

  L<URI::Find::Schemeless>

=cut

1;
