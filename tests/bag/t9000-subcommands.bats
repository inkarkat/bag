#!/usr/bin/env bats

load fixture
export PATH="${BATS_TEST_DIRNAME}/subcommands:$PATH"

@test "first argument that specifies an existing subcommand invokes that" {
    run bag test

    assert_no_bag
    [ "$output" = "this is a bag test" ]
}

@test "first argument that specifies an existing --subcommand invokes that" {
    run bag --test

    assert_no_bag
    [ "$output" = "this is a bag test" ]
}

@test "second argument that specifies an existing subcommand creates the bag" {
    run bag -- test

    assert_bag test
}
