#!/usr/bin/env bats

load temp

@test "update with nonexisting line appends after the passed line" {
    init
    UPDATE="foo=new"
    run addOrUpdateLine --line "$UPDATE" --add-after 3 "$FILE"
    [ $status -eq 0 ]
    [ "$output" = "sing/e=wha\\ever
foo=bar
foo=hoo bar baz
$UPDATE
# SECTION
foo=hi" ]
}

@test "update with nonexisting line appends after the passed ADDRESS" {
    init
    UPDATE="foo=new"
    run addOrUpdateLine --line "$UPDATE" --add-after '/^#/' "$FILE"
    [ $status -eq 0 ]
    [ "$output" = "sing/e=wha\\ever
foo=bar
foo=hoo bar baz
# SECTION
$UPDATE
foo=hi" ]
}

@test "update with existing line after the passed line keeps contents and returns 1" {
    init
    run addOrUpdateLine --line "foo=bar" --add-after 3 "$FILE"
    [ $status -eq 1 ]
    [ "$output" = "$(cat "$INPUT")" ]
}
