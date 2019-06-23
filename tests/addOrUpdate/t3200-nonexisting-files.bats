#!/usr/bin/env bats

load temp

@test "processing standard input works" {
    init
    CONTENTS="# useless"
    UPDATE="foo=new"
    output="$(echo "$CONTENTS" | addOrUpdate --line "$UPDATE")"
    [ "$output" = "$CONTENTS
$UPDATE" ]
}

@test "nonexisting file and standard input works" {
    init
    CONTENTS="# useless"
    UPDATE="foo=new"
    output="$(echo "$CONTENTS" | addOrUpdate --line "$UPDATE" "$NONE" -)"
    [ "$output" = "$CONTENTS
$UPDATE" ]
}

@test "update in first existing file skips nonexisting files" {
    init
    UPDATE="foo=new"
    run addOrUpdate --in-place --line "$UPDATE" --update-match "foo=bar" "$NONE" "$FILE" "$NONE2" "$FILE2"
    [ $status -eq 0 ]
    [ "$output" = "" ]
    [ "$(cat "$FILE")" = "sing/e=wha\\ever
$UPDATE
foo=hoo bar baz
# SECTION
foo=hi" ]
    cmp "$FILE2" "$MORE2"
    [ ! -e "$NONE" ]
    [ ! -e "$NONE2" ]
}

@test "all nonexisting files returns 4" {
    init
    UPDATE="foo=new"
    run addOrUpdate --in-place --line "$UPDATE" --update-match "foo=bar" "$NONE" "$NONE2"
    [ $status -eq 4 ]
    [ "$output" = "" ]
    [ ! -e "$NONE" ]
    [ ! -e "$NONE2" ]
}
