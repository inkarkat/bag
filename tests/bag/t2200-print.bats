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

    run -0 bag --print
    assert_output - <<'EOF'
some stuff
 in
here
EOF
}

@test "print the bag again" {
    make_bag
    bag --print >/dev/null

    run -0 bag --print
    assert_output - <<'EOF'
some stuff
 in
here
EOF
}

@test "print the bag with print action" {
    make_bag

    run -0 bag print
    assert_output - <<'EOF'
some stuff
 in
here
EOF
}

@test "print the bag with list action" {
    make_bag

    run -0 bag list
    assert_output - <<'EOF'
some stuff
 in
here
EOF
}

@test "attempting to print a non-existing bag prints an error and fails with 1" {
    run -1 bag --print
    assert_output "$BAG does not exist"
}

@test "attempting to print a non-existing bag in quiet mode just fails with 1" {
    run -1 bag --print --quiet
    assert_output ''
}
