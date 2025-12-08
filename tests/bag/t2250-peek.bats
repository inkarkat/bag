#!/usr/bin/env bats

load fixture

@test "peek the first line in the bag" {
    make_bag

    run -0 bag --peek
    assert_output 'some stuff'
}

@test "peek the first two lines in the bag" {
    make_bag

    run -0 bag --peek --lines 2
    assert_output - <<'EOF'
some stuff
 in
EOF
}

@test "peek the all existing lines in the bag" {
    make_bag

    run -0 bag --peek --lines 3
    assert_output - <<'EOF'
some stuff
 in
here
EOF
}

@test "peek the first two lines in the bag with peek action" {
    make_bag

    run -0 bag peek --lines 2
    assert_output - <<'EOF'
some stuff
 in
EOF
}

@test "attempting to peek more lines than available prints what is available and fails" {
    make_bag

    run -1 bag --peek --lines 4
    assert_output - <<'EOF'
some stuff
 in
here
EOF
}

@test "attempting to peek a line from an empty bag prints an error and fails with 1" {
    make_bag
    bag --pop -3 >/dev/null
    assert_empty_bag
    run -1 bag --peek
}

@test "attempting to peek a line from a non-existing bag prints an error and fails with 1" {
    run -1 bag --peek
    assert_output "$BAG does not exist"
}

@test "attempting to peek a non-existing bag in quiet mode just fails with 1" {
    run -1 bag --peek --quiet
    assert_output ''
}
