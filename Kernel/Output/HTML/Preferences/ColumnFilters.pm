# --
# Copyright (C) 2001-2017 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::Output::HTML::Preferences::ColumnFilters;

use strict;
use warnings;

use Kernel::Language qw(Translatable);

our @ObjectDependencies = (
    'Kernel::System::Web::Request',
    'Kernel::Config',
    'Kernel::System::JSON',
    'Kernel::System::User',
);

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {%Param};
    bless( $Self, $Type );

    for (qw(UserID ConfigItem)) {
        die "Got no $_!" if ( !$Self->{$_} );
    }

    return $Self;
}

sub Param {
    my ( $Self, %Param ) = @_;

    my @Params;
    my $GetParam = $Kernel::OM->Get('Kernel::System::Web::Request')->GetParam( Param => 'FilterAction' );

    push(
        @Params,
        {
            Name => $Self->{ConfigItem}->{PrefKey},
        },
    );
    return @Params;
}

sub Run {
    my ( $Self, %Param ) = @_;

    my $FilterAction = $Kernel::OM->Get('Kernel::System::Web::Request')->GetParam( Param => 'FilterAction' );

    return 1 if !defined $FilterAction;

    for my $Key ( sort keys %{ $Param{GetParam} } ) {

        # pref update db
        if ( !$Kernel::OM->Get('Kernel::Config')->Get('DemoSystem') ) {

            my %Seen;
            my @ColumnsUnique;
            COLUMN:
            for my $Column ( @{ $Param{GetParam}->{$Key} } ) {

                # skip duplicates
                next COLUMN if $Seen{$Column};
                $Seen{$Column} = 1;

                push @ColumnsUnique, $Column;
            }

            $Kernel::OM->Get('Kernel::System::User')->SetPreferences(
                UserID => $Param{UserData}->{UserID},
                Key    => $Key . '-' . $FilterAction,
                Value  => $Kernel::OM->Get('Kernel::System::JSON')->Encode( Data => \@ColumnsUnique ),
            );
        }
    }

    $Self->{Message} = Translatable('Preferences updated successfully!');
    return 1;
}

sub Error {
    my ( $Self, %Param ) = @_;

    return $Self->{Error} || '';
}

sub Message {
    my ( $Self, %Param ) = @_;

    return $Self->{Message} || '';
}

1;
