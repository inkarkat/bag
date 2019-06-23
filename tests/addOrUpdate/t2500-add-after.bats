#!/usr/bin/env bats

load temp

@test "update with nonexisting line appends after the passed line" {
    init
    UPDATE="foo=new"
    run addOrUpdate --line "$UPDATE" --add-after 3 "$FILE"
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
    run addOrUpdate --line "$UPDATE" --add-after '/^#/' "$FILE"
    [ $status -eq 0 ]
    [ "$output" = "sing/e=wha\\ever
foo=bar
foo=hoo bar baz
# SECTION
$UPDATE
foo=hi" ]
}

