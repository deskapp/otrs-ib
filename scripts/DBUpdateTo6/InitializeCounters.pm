# --
# Copyright (C) 2017 Informatyka Boguslawski sp. z o.o. sp.k., http://www.ib.pl/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package scripts::DBUpdateTo6::InitializeCounters;    ## no critic

use strict;
use warnings;

use base qw(scripts::DBUpdateTo6::Base);

our @ObjectDependencies = (
    'Kernel::System::DB',
    'Kernel::System::Log',
);

=head1 NAME

scripts::DBUpdateTo6::InitializeCounters - Initialize counter table.

=cut

sub Run {
    my ( $Self, %Param ) = @_;

    # get needed objects
    my $DBObject = $Kernel::OM->Get('Kernel::System::DB');

    # Initialize TicketNumber counter
    return if !$DBObject->Do(
        SQL  => "INSERT INTO counter (id, name, value, create_by, create_time, change_by, change_time) "
            . " VALUES (1, 'TicketNumber', 0, 1, current_timestamp, 1, current_timestamp)"
    );

    return 1;
}

1;

=head1 TERMS AND CONDITIONS

This software is part of the OTRS project (L<http://otrs.org/>).

This software comes with ABSOLUTELY NO WARRANTY. For details, see
the enclosed file COPYING for license information (AGPL). If you
did not receive this file, see L<http://www.gnu.org/licenses/agpl.txt>.

=cut
