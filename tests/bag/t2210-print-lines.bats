#!/usr/bin/env bats

load fixture

@test "print the first line in the bag" {
    make_bag

    run bag --print -1
    [ $status -eq 0 ]
    [ "$output" = "some stuff" ]
}

@test "print the first two lines in the bag" {
    make_bag

    run bag --print --lines 2
    [ $status -eq 0 ]
    [ "$output" = "some stuff
 in" ]
}

@test "print the first two lines in the bag again" {
    make_bag
    bag --print --lines 2 >/dev/null

    run bag --print --lines 2
    [ $status -eq 0 ]
    [ "$output" = "some stuff
 in" ]
}

@test "print more lines than available" {
    make_bag

    run bag --print --lines 4
    [ $status -eq 0 ]
    [ "$output" = "some stuff
 in
here" ]
}

@test "print lines of an empty bag prints succeeds and prints nothing" {
    make_bag
    bag --pop -3 >/dev/null
    assert_empty_bag
    run bag --print --lines 2
    [ $status -eq 0 ]
    [ "$output" = "" ]
}

@test "attempting to print lines of a non-existing bag prints an error and fails with 1" {
    run bag --print --lines 2
    [ $status -eq 1 ]
    [ "$output" = "$BAG does not exist" ]
}
