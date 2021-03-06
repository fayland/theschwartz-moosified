use strict;
use warnings;
use t::Utils;
use TheSchwartz::Moosified;

plan tests => 6;

run_test {
    my $dbh1 = shift;
    run_test {
        my $dbh2 = shift;

        my $sch = TheSchwartz::Moosified->new();
        $sch->databases([$dbh1, $dbh2]);
        isa_ok $sch, 'TheSchwartz::Moosified';
        is $sch->funcname_to_id($dbh1, 'foo'), 1;
        is $sch->funcname_to_id($dbh1, 'bar'), 2;
        is $sch->funcname_to_id($dbh1, 'foo'), 1;
        is $sch->funcname_to_id($dbh1, 'baz'), 3;
        SKIP: {
            skip "same dbh for ST",1 if ($ENV{ST_CURRENT});
            is $sch->funcname_to_id($dbh2, 'bar'), 1, 'other dbh';
        }
    };
};

