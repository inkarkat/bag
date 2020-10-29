#!/usr/bin/env bats

load fixture

@test "deleting all lines of the bag removes the bag" {
    make_bag
    run bag --delete
    [ $status -eq 0 ]
    [ "$output" = "" ]
    assert_no_bag
}

@test "deleting all lines of the bag with --print removes the bag and prints its contents" {
    make_bag
    run bag --delete --print
    [ $status -eq 0 ]
    [ "$output" = "some stuff
 in
here" ]
    assert_no_bag
}

@test "attempting to delete a non-existing bag does nothing" {
    run bag --delete
    [ $status -eq 0 ]
    [ "$output" = "" ]
}
