#!/usr/bin/env bats

load temp

@test "update with nonexisting line appends at the end" {
    init
    UPDATE="foo=new"
    run addOrUpdate --line "$UPDATE" "$FILE"
    [ $status -eq 0 ]
    [ "$output" = "$(cat "$INPUT")
$UPDATE" ]
}

@test "update with existing line keeps contents and returns 1" {
    init
    run addOrUpdate --line "foo=bar" "$FILE"
    [ $status -eq 1 ]
    [ "$output" = "$(cat "$INPUT")" ]
}

@test "update with nonexisting line containing forward and backslash appends at the end" {
    init
    UPDATE='/new\=\here/'
    run addOrUpdate --line "$UPDATE" "$FILE"
    [ $status -eq 0 ]
    [ "$output" = "$(cat "$INPUT")
$UPDATE" ]
}

@test "update with existing line containing forward and backslash keeps contents and returns 1" {
    init
    run addOrUpdate --line 'sing/e=wha\ever' "$FILE"
    [ $status -eq 1 ]
    [ "$output" = "$(cat "$INPUT")" ]
}

@test "in-place update with nonexisting line appends at the end" {
    init
    UPDATE="foo=new"
    run addOrUpdate --in-place --line "$UPDATE" "$FILE"
    [ $status -eq 0 ]
    [ "$output" = "" ]
    [ "$(cat "$FILE")" = "$(cat "$INPUT")
$UPDATE" ]
}

@test "in-place update with existing line keeps contents and returns 1" {
    init
    run addOrUpdate --in-place --line "foo=bar" "$FILE"
    [ $status -eq 1 ]
    [ "$output" = "" ]
    cmp "$FILE" "$INPUT"
}

@test "test-only update with nonexisting line succeeds" {
    init
    UPDATE="foo=new"
    run addOrUpdate --test-only --line "$UPDATE" "$FILE"
    [ $status -eq 0 ]
    [ "$output" = "" ]
    cmp "$FILE" "$INPUT"
}

@test "test-only update with existing line returns 1" {
    init
    run addOrUpdate --test-only --line "foo=bar" "$FILE"
    [ $status -eq 1 ]
    [ "$output" = "" ]
    cmp "$FILE" "$INPUT"
}
