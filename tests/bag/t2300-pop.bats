#!/usr/bin/env bats

load fixture

@test "pop the first line of the bag" {
    make_bag
    run -0 bag --pop
    assert_output 'some stuff'
}

@test "pop the first line of the bag twice" {
    make_bag
    bag --pop >/dev/null
    run -0 bag --pop
    assert_output ' in'
}

@test "pop two lines" {
    make_bag
    run -0 bag --pop --lines 2
    assert_output - <<'EOF'
some stuff
 in
EOF
}
@test "pop two lines with pop action" {
    make_bag
    run -0 bag pop --lines 2
    assert_output - <<'EOF'
some stuff
 in
EOF
}
@test "pop more lines than available" {
    make_bag
    run -0 bag --pop --lines 4
    assert_output - <<'EOF'
some stuff
 in
here
EOF
}

@test "attempting to pop a non-existing bag prints an error and fails with 1" {
    run -1 bag --pop
    assert_output "$BAG does not exist"
}

@test "attempting to pop a non-existing bag in quiet mode just fails with 1" {
    run -1 bag --pop --quiet
    assert_output ''
}
