#!/usr/bin/env bats

load fixture

@test "print the first line in the bag" {
    make_bag

    run -0 bag --print -1
    assert_output 'some stuff'
}

@test "print the first two lines in the bag" {
    make_bag

    run -0 bag --print --lines 2
    assert_output - <<'EOF'
some stuff
 in
EOF
}

@test "print the first two lines in the bag again" {
    make_bag
    bag --print --lines 2 >/dev/null

    run -0 bag --print --lines 2
    assert_output - <<'EOF'
some stuff
 in
EOF
}

@test "print the first two lines in the bag with list action" {
    make_bag

    run -0 bag list --lines 2
    assert_output - <<'EOF'
some stuff
 in
EOF
}

@test "print more lines than available" {
    make_bag

    run -0 bag --print --lines 4
    assert_output - <<'EOF'
some stuff
 in
here
EOF
}

@test "print lines of an empty bag prints succeeds and prints nothing" {
    make_bag
    bag --pop -3 >/dev/null
    assert_empty_bag
    run -0 bag --print --lines 2
    assert_output ''
}

@test "attempting to print lines of a non-existing bag prints an error and fails with 1" {
    run -1 bag --print --lines 2
    assert_output "$BAG does not exist"
}
