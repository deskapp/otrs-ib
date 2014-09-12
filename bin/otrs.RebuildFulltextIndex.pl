#!/usr/bin/perl
# --
# otrs.RebuildFulltextIndex.pl - the global search indexer handle
# Copyright (C) 2001-2014 OTRS AG, http://otrs.com/
# Copyright (C) 2014 Informatyka Boguslawski sp. z o.o. sp.k., http://www.ib.pl/
# --
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU AFFERO General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 USA
# or see http://www.gnu.org/licenses/agpl.txt.
# --

use strict;
use warnings;

use File::Basename;
use FindBin qw($RealBin);
use lib dirname($RealBin);
use lib dirname($RealBin) . '/Kernel/cpan-lib';
use lib dirname($RealBin) . '/Custom';

use Getopt::Std;
use Kernel::Config;
use Kernel::System::Encode;
use Kernel::System::Log;
use Kernel::System::Time;
use Kernel::System::DB;
use Kernel::System::Main;
use Kernel::System::Ticket;

# get options
my %Opts = ();
getopt( 'h', \%Opts );
if ( $Opts{h} ) {
    print "otrs.RebuildFulltextIndex.pl - rebuild fulltext index\n";
    print "Copyright (C) 2001-2014 OTRS AG, http://otrs.com/\n";
    print "Copyright (C) 2014 Informatyka Boguslawski sp. z o.o. sp.k., http://www.ib.pl/\n";
    print "usage: otrs.RebuildFulltextIndex.pl [-a] [-m]\n"
        . "where: -a  rebuild index of all tickets (only unarchived tickets by default)\n"
        . "       -m  rebuild only main index without any parent indexes\n";
    exit 1;
}

# create common objects
my %CommonObject = ();
$CommonObject{ConfigObject} = Kernel::Config->new();
$CommonObject{EncodeObject} = Kernel::System::Encode->new(%CommonObject);
$CommonObject{LogObject}    = Kernel::System::Log->new(
    LogPrefix => 'OTRS-otrs.RebuildFulltextIndex.pl',
    %CommonObject,
);
$CommonObject{MainObject} = Kernel::System::Main->new(%CommonObject);
$CommonObject{TimeObject} = Kernel::System::Time->new( %CommonObject, );

# create needed objects
$CommonObject{DBObject}     = Kernel::System::DB->new(%CommonObject);
$CommonObject{TicketObject} = Kernel::System::Ticket->new(%CommonObject);

# get all unarchived tickets (or all tickets if -a option given)
my $ArchiveFlags = ( $Opts{a} ) ? ['y', 'n'] : ['n'];

my @TicketIDs = $CommonObject{TicketObject}->TicketSearch(

    # result (required)
    Result => 'ARRAY',

    # result limit
    Limit      => 100_000_000,
    UserID     => 1,
    Permission => 'ro',
    ArchiveFlags => $ArchiveFlags,
);

my $Count = 0;
for my $TicketID (@TicketIDs) {

    $Count++;

    # get articles
    my @ArticleIndex = $CommonObject{TicketObject}->ArticleIndex(
        TicketID => $TicketID,
        UserID   => 1,
    );

    for my $ArticleID (@ArticleIndex) {
        $CommonObject{TicketObject}->ArticleIndexBuild(
            ArticleID     => $ArticleID,
            UserID        => 1,
            MainIndexOnly => $Opts{m},
        );
    }
    if ( $Count % 5000 == 0 ) {
        my $Percent = int( $Count / ( $#TicketIDs / 100 ) );
        print "NOTICE: $Count of $#TicketIDs processed ($Percent% done).\n";
    }
}
print "NOTICE: Index creation done.\n";

exit 0;
