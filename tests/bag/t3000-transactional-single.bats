#!/usr/bin/env bats

load fixture

@test "a piped line creates the transactional bag" {
    echo 'first entry' | bag --transactional

    assert_bag "first entry"
}

@test "an argument overwrites the bag transactionally" {
    bag --transactional -- 'entry'

    assert_bag "entry"
}

@test "print the bag transactionally" {
    make_bag

    run bag --print --transactional
    [ $status -eq 0 ]
    [ "$output" = "some stuff
 in
here" ]
}

@test "pop two lines transactionally" {
    make_bag
    run bag --pop --transactional --lines 2
    [ $status -eq 0 ]
    [ "$output" = "some stuff
 in" ]
}

@test "deleting all lines of the bag transactionally removes the bag" {
    make_bag
    run bag --delete --transactional
    [ $status -eq 0 ]
    [ "$output" = "" ]
    assert_no_bag
}
