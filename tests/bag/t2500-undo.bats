#!/usr/bin/env bats

load fixture

@test "cannot undo when there is no backup" {
    run bag --undo
    [ $status -eq 1 ]
    [ "$output" = "ERROR: Nothing to undo." ]
}

@test "undo of an operation that creates the bag restores empty bag" {
    bag -- some values
    run bag --undo
    [ $status -eq 0 ]
    [ "$output" = "" ]
    assert_empty_bag
}

@test "undo of append restores to original contents" {
    make_bag
    bag --append and more
    run bag --undo
    [ $status -eq 0 ]
    [ "$output" = "" ]
    assert_bag "some stuff
 in
here"
}

@test "undo of pop restores to original contents" {
    make_bag
    bag --pop
    run bag --undo
    [ $status -eq 0 ]
    [ "$output" = "" ]
    assert_bag "some stuff
 in
here"
}

@test "undo of set restores to original contents" {
    make_bag
    bag -- something else
    run bag --undo
    [ $status -eq 0 ]
    [ "$output" = "" ]
    assert_bag "some stuff
 in
here"
}

@test "undo of delete restores to original contents" {
    make_bag
    bag --delete
    run bag --undo
    [ $status -eq 0 ]
    [ "$output" = "" ]
    assert_bag "some stuff
 in
here"
}

@test "undo of undo restores to changed contents" {
    make_bag
    bag -- something else
    bag --undo
    run bag --undo
    [ $status -eq 0 ]
    [ "$output" = "" ]
    assert_bag "something
else"
}

@test "undo of undo of undo restores to original contents" {
    make_bag
    bag -- something else
    bag --undo
    bag --undo
    run bag --undo
    [ $status -eq 0 ]
    [ "$output" = "" ]
    assert_bag "some stuff
 in
here"
}

@test "undo with --print prints and restores to original contents" {
    make_bag
    bag -- something else
    run bag --undo --print
    [ $status -eq 0 ]
    [ "$output" = "some stuff
 in
here" ]
    assert_bag "some stuff
 in
here"
}
@test "undo --print of undo prints and restores to changed contents" {
    make_bag
    bag -- something else
    bag --undo
    run bag --undo --print
    [ $status -eq 0 ]
    [ "$output" = "something
else" ]
    assert_bag "something
else"
}
