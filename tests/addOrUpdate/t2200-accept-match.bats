#!/usr/bin/env bats

load temp

@test "update with nonmatching pattern appends at the end" {
    init
    UPDATE="foo=new"
    run addOrUpdate --line "$UPDATE" --accept-match "foosball=never" "$FILE"
    [ $status -eq 0 ]
    [ "$output" = "$(cat "$INPUT")
$UPDATE" ]
}

@test "update with literal-like pattern keeps contents and returns 1" {
    init
    run addOrUpdate --line "foo=new" --accept-match "foo=h" "$FILE"
    [ $status -eq 1 ]
    [ "$output" = "$(cat "$INPUT")" ]
}

@test "update with anchored pattern keeps contents and returns 1" {
    init
    run addOrUpdate --line "foo=new" --accept-match "^fo\+=[ghi].*$" "$FILE"
    [ $status -eq 1 ]
    [ "$output" = "$(cat "$INPUT")" ]
}
