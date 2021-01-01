#!/usr/bin/env bats

load temp

@test "update with nonmatching pattern appends multi-line at the end" {
    UPDATE=$'foo=multi\nline'
    run addOrUpdateLine --line "$UPDATE" --update-match "foosball=never" "$FILE"
    [ $status -eq 0 ]
    [ "$output" = "$(cat "$INPUT")
$UPDATE" ]
}

@test "update with literal-like pattern updates first matching line with multiple lines" {
    UPDATE=$'foo=multi\nline'
    run addOrUpdateLine --line "$UPDATE" --update-match "foo=h" "$FILE"
    [ $status -eq 0 ]
    [ "$output" = "sing/e=wha\\ever
foo=bar
$UPDATE
# SECTION
foo=hi" ]
}
