#!/usr/bin/env bats

load fixture

@test "undo of append --no-backup skips the previous modification" {
    make_bag
    bag --append inconsequential stuff
    bag --append --no-backup and some additions
    run -0 bag --undo
    assert_output ''
    assert_bag "some stuff
 in
here"
}

@test "undo of pop --no-backup skips the previous modification" {
    make_bag
    bag --pop
    bag --pop --no-backup
    run -0 bag --undo
    assert_output ''
    assert_bag "some stuff
 in
here"
}

@test "undo of set --no-backup skips the previous modification" {
    make_bag
    bag -- inconsequential stuff
    bag --no-backup -- something else
    run -0 bag --undo
    assert_output ''
    assert_bag "some stuff
 in
here"
}

@test "undo of undo --no-backup of undo restores to changed contents instead of original contents" {
    make_bag
    bag -- something else
    bag --undo
    bag --undo --no-backup
    run -0 bag --undo
    assert_output ''
    assert_bag "something
else"
}
