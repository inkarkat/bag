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
