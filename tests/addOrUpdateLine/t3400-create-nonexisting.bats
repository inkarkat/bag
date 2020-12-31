#!/usr/bin/env bats

load temp

@test "processing standard input with creation of nonexisting works" {
    CONTENTS="# useless"
    UPDATE="foo=new"
    output="$(echo "$CONTENTS" | addOrUpdateLine --create-nonexisting --line "$UPDATE")"
    [ "$output" = "$CONTENTS
$UPDATE" ]
}

@test "update with nonexisting first file creates and appends there" {
    UPDATE="foo=new"
    run addOrUpdateLine --create-nonexisting --in-place --line "$UPDATE" --update-match "foo=bar" "$NONE" "$FILE" "$NONE2" "$FILE2"
    [ $status -eq 0 ]
    [ "$output" = "" ]
    [ -e "$NONE" ]
    [ "$(cat "$NONE")" = "foo=new" ]
    cmp "$FILE" "$INPUT"
    cmp "$FILE2" "$MORE2"
    [ ! -e "$NONE2" ]
}

@test "update with all nonexisting files creates and appends to the first one" {
    UPDATE="foo=new"
    run addOrUpdateLine --create-nonexisting --in-place --line "$UPDATE" --update-match "foo=bar" "$NONE" "$NONE2"
    [ $status -eq 0 ]
    [ "$output" = "" ]
    [ -e "$NONE" ]
    [ "$(cat "$NONE")" = "foo=new" ]
    [ ! -e "$NONE2" ]
}

@test "update nonexisting file with pre line" {
    PRELINE="# new header"
    UPDATE="foo=new"
    run addOrUpdateLine --create-nonexisting --in-place --pre-line "$PRELINE" --line "$UPDATE" "$NONE"
    [ $status -eq 0 ]
    [ "$(cat "$NONE")" = "$PRELINE
$UPDATE" ]
}

@test "update nonexisting file with post line" {
    POSTLINE="# new footer"
    UPDATE="foo=new"
    run addOrUpdateLine --create-nonexisting --in-place --post-line "$POSTLINE" --line "$UPDATE" "$NONE"
    [ $status -eq 0 ]
    [ "$(cat "$NONE")" = "$UPDATE
$POSTLINE" ]
}

@test "update nonexisting file with pre and post lines" {
    PRELINE1="# new header"
    PRELINE2="more

stuff"
    UPDATE="foo=new"
    POSTLINE1="more

stuff"
    POSTLINE2="# new footer"
    run addOrUpdateLine --create-nonexisting --in-place --pre-line "$PRELINE1" --post-line "$POSTLINE1" --pre-line "$PRELINE2" --post-line "$POSTLINE2" --line "$UPDATE" "$NONE"
    [ $status -eq 0 ]
    [ "$output" = "" ]
    [ -e "$NONE" ]
    [ "$(cat "$NONE")" = "$PRELINE1
$PRELINE2
$UPDATE
$POSTLINE1
$POSTLINE2" ]
}

@test "update with nonexisting files and --all creates and appends each" {
    UPDATE="foo=new"
    run addOrUpdateLine --create-nonexisting --all --in-place --line "$UPDATE" --update-match "foo=bar" "$NONE" "$FILE" "$NONE2" "$FILE2"
    [ $status -eq 0 ]
    [ "$output" = "" ]
    [ -e "$NONE" ]
    [ -e "$NONE2" ]
    [ "$(cat "$NONE")" = "foo=new" ]
    [ "$(cat "$NONE2")" = "foo=new" ]
    [ "$(cat "$FILE")" = "sing/e=wha\\ever
$UPDATE
foo=hoo bar baz
# SECTION
foo=hi" ]
    [ "$(cat "$FILE2")" = "$UPDATE
quux=initial
foo=moo bar baz" ]
}

@test "update with all nonexisting files and --all creates and appends to each" {
    UPDATE="foo=new"
    run addOrUpdateLine --create-nonexisting --all --in-place --line "$UPDATE" --update-match "foo=bar" "$NONE" "$NONE2"
    [ $status -eq 0 ]
    [ "$output" = "" ]
    [ -e "$NONE" ]
    [ -e "$NONE2" ]
    [ "$(cat "$NONE")" = "foo=new" ]
    [ "$(cat "$NONE2")" = "foo=new" ]
}
