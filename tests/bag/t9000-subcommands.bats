#!/usr/bin/env bats

load fixture

@test "first argument creates the bag" {
    bag test

    assert_bag test
}

@test "first argument that specifies an existing subcommand invokes that" {
    export PATH="${BATS_TEST_DIRNAME}/subcommands:$PATH"
    run bag test

    assert_no_bag
    [ "$output" = "this is a bag test" ]
}

@test "second argument that specifies an existing subcommand creates the bag" {
    export PATH="${BATS_TEST_DIRNAME}/subcommands:$PATH"
    run bag -- test

    assert_bag test
}
