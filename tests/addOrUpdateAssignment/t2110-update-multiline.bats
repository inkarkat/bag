#!/usr/bin/env bats

load temp

@test "update with nonexisting assignment appends multi-line at the end" {
    UPDATE=$'new=multi\nline'
    run addOrUpdateAssignment --lhs new --rhs $'multi\nline' "$FILE"
    [ $status -eq 0 ]
    [ "$output" = "$(cat "$INPUT")
$UPDATE" ]
}

@test "update with value of multiple lines" {
    run addOrUpdateAssignment --lhs foo --rhs $'multi\nline' "$FILE"
    [ $status -eq 0 ]
    [ "$output" = "sing/e=wha\\ever
foo=multi
line
foo=hoo bar baz
# SECTION
fox=hi" ]
}
