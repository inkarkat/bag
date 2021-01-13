#!/usr/bin/env bats

load temp

@test "update with nonexisting line inserts on the passed line" {
    run addOrUpdateBlock --marker test --block-text "$TEXT" --add-before 3 "$FILE"
    [ $status -eq 0 ]
    [ "$output" = "foo=bar
foo=hoo bar baz
$BLOCK
# SECTION
foo=hi" ]
}

@test "update with nonexisting line inserts on the passed ADDRESS" {
    run addOrUpdateBlock --marker test --block-text "$TEXT" --add-before '/^#/' "$FILE"
    [ $status -eq 0 ]
    [ "$output" = "foo=bar
foo=hoo bar baz
$BLOCK
# SECTION
foo=hi" ]
}

@test "update with nonexisting line inserts on the first match of ADDRESS only" {
    run addOrUpdateBlock --marker new --block-text "$TEXT" --add-before '/^#/' "$FILE2"
    [ $status -eq 0 ]
    [ "$output" = "first line
second line
third line
# BEGIN new
single-line
# END new
# BEGIN test
The original comment
is this one.
# END test
# BEGIN subsequent
Single line
# END subsequent

middle line

# BEGIN test
Testing again
Somehoe
# END test

# BEGIN final and empty
# END final and empty
last line" ]
}

@test "update with existing marker and same multi-line block after the passed line keeps contents and returns 1" {
    run addOrUpdateBlock --marker test --block-text $'The original comment\nis this one.' --add-before 12 "$FILE2"
    [ $status -eq 1 ]
    [ "$output" = "$(cat "$EXISTING")" ]
}
