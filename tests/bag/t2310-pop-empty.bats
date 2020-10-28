#!/usr/bin/env bats

load fixture

@test "pop the last remaining line of the bag keeps an empty bag" {
    make_bag
    bag --pop -2 >/dev/null
    run bag --pop
    [ $status -eq 0 ]
    assert_empty_bag
}

@test "pop the last remaining line of the bag with --delete-empty removes the bag" {
    make_bag
    bag --pop -2 >/dev/null
    run bag --pop --delete-empty
    [ $status -eq 0 ]
    assert_no_bag
}

@test "pop all available lines of the bag with --delete-empty removes the bag" {
    make_bag
    run bag --pop --lines 3 --delete-empty
    [ $status -eq 0 ]
    assert_no_bag
}
