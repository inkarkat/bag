#!/usr/bin/env bats

load fixture

@test "deleting all lines of the bag removes the bag" {
    make_bag
    run -0 bag --delete
    assert_output ''
    assert_no_bag
}

@test "deleting all lines of the bag with delete action removes the bag" {
    make_bag
    run -0 bag delete
    assert_output ''
    assert_no_bag
}

@test "deleting all lines of the bag with --print removes the bag and prints its contents" {
    make_bag
    run -0 bag --delete --print
    assert_output - <<'EOF'
some stuff
 in
here
EOF
    assert_no_bag
}

@test "attempting to delete a non-existing bag does nothing" {
    run -0 bag --delete
    assert_output ''
}
