#!/usr/bin/env bats

load fixture

@test "cannot undo when there is no backup" {
    run -1 bag --undo
    assert_output 'ERROR: Nothing to undo.'
}

@test "undo of an operation that creates the bag restores empty bag" {
    bag -- some values
    run -0 bag --undo
    assert_output ''
    assert_empty_bag
}

@test "undo of append restores to original contents" {
    make_bag
    bag --append and more
    run -0 bag --undo
    assert_output ''
    assert_bag "some stuff
 in
here"
}

@test "undo of pop restores to original contents" {
    make_bag
    bag --pop
    run -0 bag --undo
    assert_output ''
    assert_bag "some stuff
 in
here"
}

@test "undo of set restores to original contents" {
    make_bag
    bag -- something else
    run -0 bag --undo
    assert_output ''
    assert_bag "some stuff
 in
here"
}

@test "undo of delete restores to original contents" {
    make_bag
    bag --delete
    run -0 bag --undo
    assert_output ''
    assert_bag "some stuff
 in
here"
}

@test "undo of undo restores to changed contents" {
    make_bag
    bag -- something else
    bag --undo
    run -0 bag --undo
    assert_output ''
    assert_bag "something
else"
}

@test "undo of undo of undo restores to original contents" {
    make_bag
    bag -- something else
    bag --undo
    bag --undo
    run -0 bag --undo
    assert_output ''
    assert_bag "some stuff
 in
here"
}

@test "undo with --print prints and restores to original contents" {
    make_bag
    bag -- something else
    run -0 bag --undo --print
    assert_output - <<'EOF'
some stuff
 in
here
EOF
    assert_bag "some stuff
 in
here"
}

@test "undo --print of undo prints and restores to changed contents" {
    make_bag
    bag -- something else
    bag --undo
    run -0 bag --undo --print
    assert_output - <<'EOF'
something
else
EOF
    assert_bag "something
else"
}
