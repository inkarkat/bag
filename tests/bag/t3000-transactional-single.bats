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

    run -0 bag --print --transactional
    assert_output - <<'EOF'
some stuff
 in
here
EOF
}

@test "pop two lines transactionally" {
    make_bag
    run -0 bag --pop --transactional --lines 2
    assert_output - <<'EOF'
some stuff
 in
EOF
}

@test "deleting all lines of the bag transactionally removes the bag" {
    make_bag
    run -0 bag --delete --transactional
    assert_output ''
    assert_no_bag
}
