#!/usr/bin/env bats

load temp

@test "processing standard input with creation of nonexisting works" {
    CONTENTS="# useless"
    output="$(echo "$CONTENTS" | addOrUpdateAssignment --create-nonexisting --lhs foo --rhs new)"
    [ "$output" = "$CONTENTS
foo=new" ]
}

@test "update with nonexisting first file creates and appends there" {
    run addOrUpdateAssignment --create-nonexisting --in-place --lhs foo --rhs new "$NONE" "$FILE" "$NONE2" "$FILE2"
    [ $status -eq 0 ]
    [ "$output" = "" ]
    [ -e "$NONE" ]
    [ "$(cat "$NONE")" = "foo=new" ]
    cmp "$FILE" "$INPUT"
    cmp "$FILE2" "$MORE2"
    [ ! -e "$NONE2" ]
}

@test "update with all nonexisting files creates and appends to the first one" {
    run addOrUpdateAssignment --create-nonexisting --in-place --lhs foo --rhs new "$NONE" "$NONE2"
    [ $status -eq 0 ]
    [ "$output" = "" ]
    [ -e "$NONE" ]
    [ "$(cat "$NONE")" = "foo=new" ]
    [ ! -e "$NONE2" ]
}

@test "update nonexisting file with pre line" {
    PRELINE="# new header"
    run addOrUpdateAssignment --create-nonexisting --in-place --pre-line "$PRELINE" --lhs new --rhs add "$NONE"
    [ $status -eq 0 ]
    [ "$(cat "$NONE")" = "$PRELINE
new=add" ]
}

@test "update nonexisting file with post line" {
    POSTLINE="# new footer"
    run addOrUpdateAssignment --create-nonexisting --in-place --post-line "$POSTLINE" --lhs new --rhs add "$NONE"
    [ $status -eq 0 ]
    [ "$(cat "$NONE")" = "new=add
$POSTLINE" ]
}

@test "update nonexisting file with pre and post lines" {
    PRELINE1="# new header"
    PRELINE2="more

stuff"
    POSTLINE1="more

stuff"
    POSTLINE2="# new footer"
    run addOrUpdateAssignment --create-nonexisting --in-place --pre-line "$PRELINE1" --post-line "$POSTLINE1" --pre-line "$PRELINE2" --post-line "$POSTLINE2" --lhs foo --rhs new "$NONE"
    [ $status -eq 0 ]
    [ "$output" = "" ]
    [ -e "$NONE" ]
    [ "$(cat "$NONE")" = "$PRELINE1
$PRELINE2
foo=new
$POSTLINE1
$POSTLINE2" ]
}

@test "update with nonexisting files and --all creates and appends each" {
    run addOrUpdateAssignment --create-nonexisting --all --in-place --lhs foo --rhs new "$NONE" "$FILE" "$NONE2" "$FILE2"
    [ $status -eq 0 ]
    [ "$output" = "" ]
    [ -e "$NONE" ]
    [ -e "$NONE2" ]
    [ "$(cat "$NONE")" = "foo=new" ]
    [ "$(cat "$NONE2")" = "foo=new" ]
    [ "$(cat "$FILE")" = "sing/e=wha\\ever
foo=new
foo=hoo bar baz
# SECTION
fox=hi" ]
    [ "$(cat "$FILE2")" = "foo=new
quux=initial
foo=moo bar baz" ]
}

@test "update with all nonexisting files and --all creates and appends to each" {
    run addOrUpdateAssignment --create-nonexisting --all --in-place --lhs new --rhs add "$NONE" "$NONE2"
    [ $status -eq 0 ]
    [ "$output" = "" ]
    [ -e "$NONE" ]
    [ -e "$NONE2" ]
    [ "$(cat "$NONE")" = "new=add" ]
    [ "$(cat "$NONE2")" = "new=add" ]
}
