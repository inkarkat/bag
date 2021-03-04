#!/usr/bin/env bats

load fixture

@test "peek the first line in the bag" {
    make_bag

    run bag --peek
    [ $status -eq 0 ]
    [ "$output" = "some stuff" ]
}

@test "peek the first two lines in the bag" {
    make_bag

    run bag --peek --lines 2
    [ $status -eq 0 ]
    [ "$output" = "some stuff
 in" ]
}

@test "peek the all existing lines in the bag" {
    make_bag

    run bag --peek --lines 3
    [ $status -eq 0 ]
    [ "$output" = "some stuff
 in
here" ]
}

@test "attempting to peek more lines than available prints what is available and fails" {
    make_bag

    run bag --peek --lines 4
    [ $status -eq 1 ]
    [ "$output" = "some stuff
 in
here" ]
}

@test "attempting to peek a line from an empty bag prints an error and fails with 1" {
    make_bag
    bag --pop -3 >/dev/null
    assert_empty_bag
    run bag --peek
    [ $status -eq 1 ]
}

@test "attempting to peek a line from a non-existing bag prints an error and fails with 1" {
    run bag --peek
    [ $status -eq 1 ]
    [ "$output" = "$BAG does not exist" ]
}

@test "attempting to peek a non-existing bag in quiet mode just fails with 1" {
    run bag --peek --quiet
    [ $status -eq 1 ]
    [ "$output" = "" ]
}
