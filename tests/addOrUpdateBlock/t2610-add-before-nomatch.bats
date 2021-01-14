#!/usr/bin/env bats

load temp

@test "update with nonexisting block does not insert at all if passed ADDRESS is not reached" {
    run addOrUpdateBlock --marker test --block-text "$TEXT" --add-before 9999 "$FILE"
    [ $status -eq 0 ]
    [ "$output" = "foo=bar
foo=hoo bar baz
# SECTION
foo=hi" ]
}

@test "update with nonexisting block does not insert at all if passed ADDRESS does not match" {
    run addOrUpdateBlock --marker test --block-text "$TEXT" --add-before '/^notFoundAnyWhere/' "$FILE"
    [ $status -eq 0 ]
    [ "$output" = "foo=bar
foo=hoo bar baz
# SECTION
foo=hi" ]
}
