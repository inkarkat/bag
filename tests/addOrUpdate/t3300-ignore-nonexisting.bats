#!/usr/bin/env bats

load temp

@test "passing just nonexisting files succeeds" {
    init
    UPDATE="foo=new"
    run addOrUpdate --ignore-nonexisting --in-place --line "$UPDATE" --update-match "foo=bar" "$NONE" "$NONE2"
    [ $status -eq 0 ]
    [ "$output" = "" ]
    [ ! -e "$NONE" ]
    [ ! -e "$NONE2" ]
}

@test "passing just nonexisting files succeeds with --all" {
    init
    UPDATE="foo=new"
    run addOrUpdate --all --ignore-nonexisting --in-place --line "$UPDATE" --update-match "foo=bar" "$NONE" "$NONE2"
    [ $status -eq 0 ]
    [ "$output" = "" ]
    [ ! -e "$NONE" ]
    [ ! -e "$NONE2" ]
}
