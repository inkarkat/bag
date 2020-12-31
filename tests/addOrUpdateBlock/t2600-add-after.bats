#!/usr/bin/env bats

load temp

@test "update with nonexisting line appends after the passed line" {
    run addOrUpdateBlock --marker test --block-text "$TEXT" --add-after 2 "$FILE"
    [ $status -eq 0 ]
    [ "$output" = "foo=bar
foo=hoo bar baz
$BLOCK
# SECTION
foo=hi" ]
}

@test "update with nonexisting line appends after the passed ADDRESS" {
    run addOrUpdateBlock --marker test --block-text "$TEXT" --add-after '/^#/' "$FILE"
    [ $status -eq 0 ]
    [ "$output" = "foo=bar
foo=hoo bar baz
# SECTION
$BLOCK
foo=hi" ]
}

@test "update with existing marker and same multi-line block after the passed line keeps contents and returns 1" {
    run addOrUpdateBlock --marker test --block-text $'The original comment\nis this one.' --add-after 12 "$FILE2"
    [ $status -eq 1 ]
    [ "$output" = "$(cat "$EXISTING")" ]
}
