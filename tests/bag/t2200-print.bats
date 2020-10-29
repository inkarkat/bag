#!/usr/bin/env bats

load fixture

@test "implicitly print the bag if output is to the terminal" {
    { exec >/dev/tty; } 2>/dev/null || skip 'cannot access terminal'

    make_bag
    printf '' || bag > /dev/tty

    assert_bag "some stuff
 in
here"
}

@test "print the bag" {
    make_bag

    run bag --print
    [ $status -eq 0 ]
    [ "$output" = "some stuff
 in
here" ]
}

@test "print the bag again" {
    make_bag
    bag --print >/dev/null

    run bag --print
    [ $status -eq 0 ]
    [ "$output" = "some stuff
 in
here" ]
}

@test "attempting to print a non-existing bag prints an error and fails with 1" {
    run bag --print
    [ $status -eq 1 ]
    [ "$output" = "$BAG does not exist" ]
}
