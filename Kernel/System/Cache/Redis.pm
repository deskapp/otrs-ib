# --
# Kernel/System/Cache/Redis.pm - Redis cache module
# Copyright (C) 2014 Informatyka Boguslawski sp. z o.o. sp.k., http://www.ib.pl/
# Based on:
#   FileStorable.pm by OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::System::Cache::Redis;

use strict;
use warnings;

use Storable qw();
use Digest::MD5 qw();
use Redis;
use Try::Tiny;

use vars qw(@ISA);

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {};
    bless( $Self, $Type );

    # check needed objects
    for (qw(ConfigObject LogObject MainObject EncodeObject)) {
        $Self->{$_} = $Param{$_} || die "Got no $_!";
    }

    # Specify in how many groups to divide keys while executing CleanUp for given
    # key type (to avoid generating too log lists in redis KEYS call). See comments
    # in CleanUp below.
    $Self->{'Cache::SubdirLevels'} = $Self->{ConfigObject}->Get('Cache::SubdirLevels');
    $Self->{'Cache::SubdirLevels'} = 1 if !defined $Self->{'Cache::SubdirLevels'};

    # get redis connection parameters and open connection to cache
    $Self->{Config} = $Self->{ConfigObject}->Get('Cache::Module::Redis');
    if ($Self->{Config} && $Self->{Config}->{Parameters} && $Self->{Config}->{Parameters}->{server}) {
        try {
            $Self->{RedisObject} = Redis->new(%{ $Self->{Config}->{Parameters} });
        };

        if (!$Self->{RedisObject}) {
            $Self->{LogObject}->Log(
                Priority => 'error',
                Message  => "Unable to initialize Redis connection to "
                    . $Self->{Config}->{Parameters}->{server} . ": $!",
            );
        }
    }
    else {
        $Self->{LogObject}->Log(
            Priority => 'error',
            Message  => 'Redis enabled but no valid Cache::Module::Redis configuration found!',
        );
    }

    return $Self;
}

sub Set {
    my ( $Self, %Param ) = @_;

    for (qw(Type Key Value TTL)) {
        if ( !defined $Param{$_} ) {
            $Self->{LogObject}->Log( Priority => 'error', Message => "Need $_!" );
            return;
        }
    }

    return if !$Self->{RedisObject};

    my $RedisKeyName = $Self->_getRedisKeyName(%Param);

    my $Content = Storable::nfreeze(
        {
            Value => $Param{Value},
        }
    );

    my $Result;
    try {
        $Result = $Self->{RedisObject}->setex($RedisKeyName, $Param{TTL}, $Content);
    }
    catch {
        # communication error; avoid calling cache server in next calls
        undef $Self->{RedisObject};
    };

    return $Result;
}

sub Get {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for (qw(Type Key)) {
        if ( !defined $Param{$_} ) {
            $Self->{LogObject}->Log( Priority => 'error', Message => "Need $_!" );
            return;
        }
    }

    return if !$Self->{RedisObject};

    my $RedisKeyName = $Self->_getRedisKeyName(%Param);

    my $Content;
    try {
        $Content = $Self->{RedisObject}->get($RedisKeyName);
    }
    catch {
        $Content = 0;

        # communication error; avoid calling cache server in next calls
        undef $Self->{RedisObject};
    };

    # check if cache exists
    return if !$Content;

    # read data structure back from cache dump, use block eval for safety reasons
    my $Storage = eval { Storable::thaw( $Content ) };
    if ( ref $Storage ne 'HASH' ) {
        $Self->Delete(%Param);
        return;
    }

    return $Storage->{Value};
}

sub Delete {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for (qw(Type Key)) {
        if ( !defined $Param{$_} ) {
            $Self->{LogObject}->Log( Priority => 'error', Message => "Need $_!" );
            return;
        }
    }

    return if !$Self->{RedisObject};

    my $RedisKeyName = $Self->_getRedisKeyName(%Param);

    my $Result;
    try {
        $Result = ($Self->{RedisObject}->del($RedisKeyName) == 1);
    }
    catch {
        $Self->{LogObject}->Log(
            Priority => 'error',
            Message  => "Error deleting key $RedisKeyName from cache: $!",
        );

        # communication error; avoid calling cache server in next calls
        undef $Self->{RedisObject};
    };

    return $Result;
}

sub CleanUp {
    my ( $Self, %Param ) = @_;

    return if !$Self->{RedisObject};

    # memcached expires data automatically
    return 1 if $Param{Expired};

    my $Result;
    if ( $Param{Type} ) {

        try {
            # if Cache::SubdirLevels > 0 then process keys in 16^Cache::SubdirLevels
            # groups to avoid receiving and processing too large key list in one shot;
            # if Cache::SubdirLevels is not defined or 0 - delete all matching keys
            # in one group
            for (my $i=0; $i < 16 ** $Self->{'Cache::SubdirLevels'}; $i++) {
                my @KeysToDelete = $Self->{RedisObject}->keys( $Param{Type} . ':' .
                    lc(substr(sprintf("%0" . $Self->{'Cache::SubdirLevels'} . "x", $i),
                        0, $Self->{'Cache::SubdirLevels'})) . '*' );
                foreach (@KeysToDelete) {
                    if ($Self->{RedisObject}->del($_) != 1) {
                        $Self->{LogObject}->Log(
                            Priority => 'notice',
                            Message  => "Cannot remove key $_ from cache (other process did it maybe): $!",
                        );
                    }
                }
            }
            $Result = 1;
        }
        catch {
            $Self->{LogObject}->Log(
                Priority => 'error',
                Message  => "Error while removing $Param{Type} data from cache: $!",
            );

            # communication error; avoid calling cache server in next calls
            undef $Self->{RedisObject};
        };
    }
    else {
        try {
            $Self->{RedisObject}->flushdb();
            $Result = 1;
        }
        catch {
            $Self->{LogObject}->Log(
                Priority => 'error',
                Message  => "Error while flushing cache: $!",
            );

            # communication error; avoid calling cache server in next calls
            undef $Self->{RedisObject};
        };
    }

    return $Result;
}

=item _getRedisKeyName()

Use MD5 digest of Key for cache key; we use here algo similar to original
one from FileStorable.pm.

    my $RedisKeyName = $Self->_getRedisKeyName(
        'SomeKey',
    );

=cut

sub _getRedisKeyName {
    my ( $Self, %Param ) = @_;

    my $Key = $Param{Key};

    # encoding required for UTF-8 strings
    # see http://search.cpan.org/dist/Digest-MD5/MD5.pm
    $Self->{EncodeObject}->EncodeOutput( \$Key );

    $Key = lc(Digest::MD5::md5_hex($Key));
    $Key = $Param{Type} . ':' . $Key;

    return $Key;
}

1;
