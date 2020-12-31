#!/usr/bin/env bats

load temp

@test "processing standard input with creation of nonexisting works" {
    CONTENTS="# useless"
    output="$(echo "$CONTENTS" | addOrUpdateBlock --create-nonexisting --marker test --block-text "$TEXT")"
    [ "$output" = "$CONTENTS
$BLOCK" ]
}

@test "update with nonexisting first file creates and appends there" {
    run addOrUpdateBlock --create-nonexisting --in-place --marker test --block-text "$TEXT" "$NONE" "$FILE" "$NONE2" "$FILE2"
    [ $status -eq 0 ]
    [ "$output" = "" ]
    [ -e "$NONE" ]
    [ "$(cat "$NONE")" = "$BLOCK" ]
    cmp "$FILE" "$FRESH"
    cmp "$FILE2" "$EXISTING"
    [ ! -e "$NONE2" ]
}

@test "update with all nonexisting files creates and appends to the first one" {
    run addOrUpdateBlock --create-nonexisting --in-place --marker test --block-text "$TEXT" "$NONE" "$NONE2"
    [ $status -eq 0 ]
    [ "$output" = "" ]
    [ -e "$NONE" ]
    [ "$(cat "$NONE")" = "$BLOCK" ]
    [ ! -e "$NONE2" ]
}

@test "update nonexisting file with pre line" {
    PRELINE="# new header"
    run addOrUpdateBlock --create-nonexisting --in-place --pre-line "$PRELINE" --marker test --block-text "$TEXT" "$NONE"
    [ $status -eq 0 ]
    [ "$output" = "" ]
    [ -e "$NONE" ]
    [ "$(cat "$NONE")" = "$PRELINE
$BLOCK" ]
}

@test "update nonexisting file with post line" {
    POSTLINE="# new footer"
    run addOrUpdateBlock --create-nonexisting --in-place --post-line "$POSTLINE" --marker test --block-text "$TEXT" "$NONE"
    [ $status -eq 0 ]
    [ "$output" = "" ]
    [ -e "$NONE" ]
    [ "$(cat "$NONE")" = "$BLOCK
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
    run addOrUpdateBlock --create-nonexisting --in-place --pre-line "$PRELINE1" --post-line "$POSTLINE1" --pre-line "$PRELINE2" --post-line "$POSTLINE2" --marker test --block-text "$TEXT" "$NONE"
    [ $status -eq 0 ]
    [ "$output" = "" ]
    [ -e "$NONE" ]
    [ "$(cat "$NONE")" = "$PRELINE1
$PRELINE2
$BLOCK
$POSTLINE1
$POSTLINE2" ]
}

@test "update with nonexisting files and --all creates and appends each" {
    run addOrUpdateBlock --create-nonexisting --all --in-place --marker test --block-text "$TEXT" "$NONE" "$FILE" "$NONE2" "$FILE2"
    [ $status -eq 0 ]
    [ "$output" = "" ]
    [ -e "$NONE" ]
    [ -e "$NONE2" ]
    [ "$(cat "$NONE")" = "$BLOCK" ]
    [ "$(cat "$FILE")" = "$(cat "$FRESH")
$BLOCK" ]
    [ "$(cat "$NONE2")" = "$BLOCK" ]
    [ "$(cat "$FILE2")" = "first line
second line
third line
# BEGIN test
$TEXT
# END test
# BEGIN subsequent
Single line
# END subsequent

middle line

# BEGIN test
Testing again
Somehoe
# END test

# BEGIN final and empty
# END final and empty
last line" ]
}

@test "update with all nonexisting files and --all creates and appends to each" {
    run addOrUpdateBlock --create-nonexisting --all --in-place --marker test --block-text "$TEXT" "$NONE" "$NONE2"
    [ $status -eq 0 ]
    [ "$output" = "" ]
    [ -e "$NONE" ]
    [ -e "$NONE2" ]
    [ "$(cat "$NONE")" = "$BLOCK" ]
    [ "$(cat "$NONE2")" = "$BLOCK" ]
}
