#!/usr/bin/perl
# --
# Copyright (C) 2001-2016 OTRS AG, http://otrs.com/
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

# use ../ as lib location
use File::Basename;
use FindBin qw($RealBin);
use lib dirname($RealBin);
use lib dirname($RealBin) . '/Kernel/cpan-lib';

use Getopt::Std qw();
use Kernel::Config;
use Kernel::System::Cache;
use Kernel::System::ObjectManager;
use Kernel::System::Package;
use Kernel::System::SysConfig;

use Kernel::System::VariableCheck qw(:all);

local $Kernel::OM = Kernel::System::ObjectManager->new(
    'Kernel::System::Log' => {
        LogPrefix => 'OTRS-DBUpdate-to-6.pl',
    },
);

{

    # get options
    my %Opts;
    Getopt::Std::getopt( 'h', \%Opts );

    if ( exists $Opts{h} ) {
        print <<"EOF";

DBUpdate-to-6.pl - Upgrade script for OTRS 5 to 6 migration.
Copyright (C) 2001-2015 OTRS AG, http://otrs.com/

Usage: $0 [-h]
    Options are as follows:
        -h      display this help

EOF
        exit 1;
    }

    # UID check
    if ( $> == 0 ) {    # $EFFECTIVE_USER_ID
        die "
Cannot run this program as root.
Please run it as the 'otrs' user or with the help of su:
    su -c \"$0\" -s /bin/bash otrs
";
    }

    # enable auto-flushing of STDOUT
    $| = 1;             ## no critic

    # define tasks and their messages
    my @Tasks = (
        {
            Message => 'Refresh configuration cache',
            Command => \&RebuildConfig,
        },
        {
            Message => 'Check framework version',
            Command => \&_CheckFrameworkVersion,
        },
        {
            Message => 'Drop deprecated table gi_object_lock_state',
            Command => \&_DropObjectLockState,
        },
        {
            Message => 'Migrate PossibleNextActions setting',
            Command => \&_MigratePossibleNextActions,
        },

        # ...

        {
            Message => 'Clean up the cache',
            Command => sub {
                $Kernel::OM->Get('Kernel::System::Cache')->CleanUp();
            },
        },
        {
            Message => 'Refresh configuration cache another time',
            Command => \&RebuildConfig,
        },
    );

    print "\nMigration started...\n\n";

    # get the number of total steps
    my $Steps = scalar @Tasks;
    my $Step  = 1;
    for my $Task (@Tasks) {

        # show task message
        print "Step $Step of $Steps: $Task->{Message}...";

        # run task command
        if ( &{ $Task->{Command} } ) {
            print "done.\n\n";
        }
        else {
            print "error.\n\n";
            die;
        }

        $Step++;
    }

    print "Migration completed!\n";

    exit 0;
}

=item RebuildConfig()

refreshes the configuration to make sure that a ZZZAAuto.pm is present
after the upgrade.

    RebuildConfig();

=cut

sub RebuildConfig {

    my $SysConfigObject = Kernel::System::SysConfig->new();

    # Rebuild ZZZAAuto.pm with current values
    if ( !$SysConfigObject->WriteDefault() ) {
        die "Error: Can't write default config files!";
    }

    # Force a reload of ZZZAuto.pm and ZZZAAuto.pm to get the new values
    for my $Module ( sort keys %INC ) {
        if ( $Module =~ m/ZZZAA?uto\.pm$/ ) {
            delete $INC{$Module};
        }
    }

    # reload config object
    print "\nIf you see warnings about 'Subroutine Load redefined', that's fine, no need to worry!\n";

    # create common objects with new default config
    $Kernel::OM->ObjectsDiscard();

    return 1;
}

=item _CheckFrameworkVersion()

Check if framework it's the correct one for Dynamic Fields migration.

    _CheckFrameworkVersion();

=cut

sub _CheckFrameworkVersion {
    my $Home = $Kernel::OM->Get('Kernel::Config')->Get('Home');

    # load RELEASE file
    if ( -e !"$Home/RELEASE" ) {
        die "Error: $Home/RELEASE does not exist!";
    }
    my $ProductName;
    my $Version;
    if ( open( my $Product, '<', "$Home/RELEASE" ) ) {    ## no critic
        while (<$Product>) {

            # filtering of comment lines
            if ( $_ !~ /^#/ ) {
                if ( $_ =~ /^PRODUCT\s{0,2}=\s{0,2}(.*)\s{0,2}$/i ) {
                    $ProductName = $1;
                }
                elsif ( $_ =~ /^VERSION\s{0,2}=\s{0,2}(.*)\s{0,2}$/i ) {
                    $Version = $1;
                }
            }
        }
        close($Product);
    }
    else {
        die "Error: Can't read $Home/RELEASE: $!";
    }

    if ( $ProductName ne 'OTRS' ) {
        die "Error: No OTRS system found"
    }
    if ( $Version !~ /^6\.0(.*)$/ ) {

        die "Error: You are trying to run this script on the wrong framework version $Version!"
    }

    return 1;
}

=item _DropObjectLockState()

Drop deprecated gi_object_lock_state table if empty.

    _DropObjectLockState();

=cut

sub _DropObjectLockState {

    # get needed objects
    my $DBObject = $Kernel::OM->Get('Kernel::System::DB');

    my %Tables = map { lc($_) => 1 } $DBObject->ListTables();
    return 1 if !$Tables{gi_object_lock_state};

    # get number of remaining entries
    return if !$DBObject->Prepare(
        SQL => 'SELECT COUNT(*) FROM gi_object_lock_state',
    );

    my $Count;
    while ( my @Row = $DBObject->FetchrowArray() ) {
        $Count = $Row[0];
    }

    # delete table but only if table is empty
    # if there are some entries left, these must be deleted by other modules
    # so we give them a chance to be migrated from these modules
    if ($Count) {
        print STDERR
            "\nThere are still entries in your gi_object_lock_state table, therefore it will not be deleted.\n";
        return 1;
    }

    # drop table 'notifications'
    my $XMLString = '<TableDrop Name="gi_object_lock_state"/>';

    my @SQL;
    my @SQLPost;

    my $XMLObject = $Kernel::OM->Get('Kernel::System::XML');

    # create database specific SQL and PostSQL commands
    my @XMLARRAY = $XMLObject->XMLParse( String => $XMLString );

    # create database specific SQL
    push @SQL, $DBObject->SQLProcessor(
        Database => \@XMLARRAY,
    );

    # create database specific PostSQL
    push @SQLPost, $DBObject->SQLProcessorPost();

    # execute SQL
    for my $SQL ( @SQL, @SQLPost ) {
        my $Success = $DBObject->Do( SQL => $SQL );
        if ( !$Success ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Error during execution of '$SQL'!",
            );
            return;
        }
    }

    return 1;
}

# The seetting "PossibleNextActions" was changed in OTRS 6. Make sure that it is adopted also for systems
#   that had this setting locally modified. Basically keys and values have be swapped, but only once.
sub _MigratePossibleNextActions {
    my $PossibleNextActions = $Kernel::OM->Get('Kernel::Config')->Get('PossibleNextActions') || {};

    # create a lookup array to no not modify the looping variable
    my @Actions = sort keys %{ $PossibleNextActions // {} };

    my $Updated;
    ACTION:
    for my $Action (@Actions) {

        # skip all keys that looks like an URL (e.g. TT Env('CGIHandle')
        #   or staring with http(s), ftp(s), matilto:, ot www.)
        next ACTION if $Action =~ m{\A \[% [\s]+ Env\( }msxi;
        next ACTION if $Action =~ m{\A http [s]? :// }msxi;
        next ACTION if $Action =~ m{\A ftp [s]? :// }msxi;
        next ACTION if $Action =~ m{\A mailto : }msxi;
        next ACTION if $Action =~ m{\A www \. }msxi;

        # remember the value for the current key
        my $ActionValue = $PossibleNextActions->{$Action};

        # remove current key and add the inverted key value pair
        delete $PossibleNextActions->{$Action};
        $PossibleNextActions->{$ActionValue} = $Action;

        $Updated = 1;
    }

    return 1 if !$Updated;

    my $Success = $Kernel::OM->Get('Kernel::System::SysConfig')->ConfigItemUpdate(
        Valid => 1,
        Key   => 'PossibleNextActions',
        Value => $PossibleNextActions,
    );
    return $Success;
}

1;
