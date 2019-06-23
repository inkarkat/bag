#!/usr/bin/env bats

load temp

@test "update in first file appends to all other files" {
    init
    UPDATE="foo=new"
    addOrUpdate --all --in-place --line "$UPDATE" --update-match "foo=bar" "$FILE" "$FILE2" "$FILE3"
    [ "$(cat "$FILE")" = "sing/e=wha\\ever
$UPDATE
foo=hoo bar baz
# SECTION
foo=hi" ]
    [ "$(cat "$FILE2")" = "$UPDATE
quux=initial
foo=moo bar baz" ]
    [ "$(cat "$FILE3")" = "zulu=here
$UPDATE
foo=no bar baz" ]
}

@test "update with match in second file appends to previous and following files" {
    init
    UPDATE="quux=updated"
    addOrUpdate --all --in-place --line "$UPDATE" --update-match "quux=" "$FILE" "$FILE2" "$FILE3"
    [ "$(cat "$FILE")" = "$(cat "$INPUT")
$UPDATE" ]
    [ "$(cat "$FILE2")" = "foo=bar
$UPDATE
foo=moo bar baz" ]
    [ "$(cat "$FILE3")" = "$(cat "$MORE3")
$UPDATE" ]
}

@test "update with existing line in all files keeps contents and returns 1" {
    init
    run addOrUpdate --all --in-place --line "foo=bar" "$FILE" "$FILE2" "$FILE3"
    [ $status -eq 1 ]
    cmp "$FILE" "$INPUT"
    cmp "$FILE2" "$MORE2"
    cmp "$FILE3" "$MORE3"
}

@test "update with existing line in first file appends at the end of the other files" {
    init
    UPDATE="foo=hoo bar baz"
    addOrUpdate --all --in-place --line "$UPDATE" "$FILE" "$FILE2" "$FILE3"
    cmp "$FILE" "$INPUT"
    [ "$(cat "$FILE2")" = "$(cat "$MORE2")
$UPDATE" ]
    [ "$(cat "$FILE3")" = "$(cat "$MORE3")
$UPDATE" ]
}

@test "update with nonexisting line appends to all files" {
    init
    UPDATE="foo=new"
    addOrUpdate --all --in-place --line "$UPDATE" "$FILE" "$FILE2" "$FILE3"
    [ "$(cat "$FILE")" = "$(cat "$INPUT")
$UPDATE" ]
    [ "$(cat "$FILE2")" = "$(cat "$MORE2")
$UPDATE" ]
    [ "$(cat "$FILE3")" = "$(cat "$MORE3")
$UPDATE" ]
}

