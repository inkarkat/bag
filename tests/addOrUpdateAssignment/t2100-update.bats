#!/usr/bin/env bats

load temp

@test "update with nonexisting assignment appends at the end" {
    run addOrUpdateAssignment --lhs new --rhs add "$FILE"
    [ $status -eq 0 ]
    [ "$output" = "$(cat "$INPUT")
new=add" ]
}

@test "update with assignee containing forward slash updates" {
    run addOrUpdateAssignment --lhs 'sing/e' --rhs 'whe\reever' "$FILE"
    [ $status -eq 0 ]
    [ "$output" = 'sing/e=whe\reever
foo=bar
foo=hoo bar baz
# SECTION
fox=hi' ]
}
