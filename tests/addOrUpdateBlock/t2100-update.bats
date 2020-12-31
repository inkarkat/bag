#!/usr/bin/env bats

load temp

@test "update with nonexisting marker and single-line block appends the block" {
    init
    run addOrUpdateBlock --marker test --block-text "single-line" "$FILE"
    [ $status -eq 0 ]
    [ "$output" = "$(cat "$FRESH")
# BEGIN test
single-line
# END test" ]
}

@test "update with nonexisting marker and multi-line block appends the block" {
    init
    run addOrUpdateBlock --marker test --block-text $'across\nmultiple\nlines' "$FILE"
    [ $status -eq 0 ]
    [ "$output" = "$(cat "$FRESH")
# BEGIN test
across
multiple
lines
# END test" ]
}

@test "update with existing marker and same single-line block keeps contents and returns 1" {
    init
    run addOrUpdateBlock --marker subsequent --block-text "Single line" "$FILE2"
    [ $status -eq 1 ]
    [ "$output" = "$(cat "$EXISTING")" ]
}

@test "update with existing marker and different single-line block updates the block" {
    init
    run addOrUpdateBlock --marker subsequent --block-text "Changed line" "$FILE2"
    [ $status -eq 0 ]
    [ "$output" = "first line
second line
third line
# BEGIN test
The original comment
is this one.
# END test
# BEGIN subsequent
Changed line
# END subsequent

middle line

# BEGIN test
Testing again
Somehoe
# END test

#BEGIN final and empty
#END final and empty
last line" ]
}

@test "update with existing marker and same multi-line block keeps contents and returns 1" {
    init
    run addOrUpdateBlock --marker test --block-text $'The original comment\nis this one.' "$FILE2"
    [ $status -eq 1 ]
    [ "$output" = "$(cat "$EXISTING")" ]
}
