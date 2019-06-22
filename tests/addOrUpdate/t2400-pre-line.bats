#!/usr/bin/env bats

load temp

@test "append with one pre line" {
    init
    PRELINE="# new header"
    UPDATE="foo=new"
    run addOrUpdate --pre-line "$PRELINE" --line "$UPDATE" "$FILE"
    [ $status -eq 0 ]
    [ "$output" = "$(cat "$INPUT")
$PRELINE
$UPDATE" ]
}

@test "append with three separate pre lines" {
    init
    PRELINE1="# first header"
    PRELINE2=''
    PRELINE3="# third header"
    UPDATE="foo=new"
    run addOrUpdate --pre-line "$PRELINE1" --pre-line "$PRELINE2" --pre-line "$PRELINE3" --line "$UPDATE" "$FILE"
    [ $status -eq 0 ]
    [ "$output" = "$(cat "$INPUT")
$PRELINE1
$PRELINE2
$PRELINE3
$UPDATE" ]
}

@test "append with one multi-line pre line" {
    init
    PRELINE="# first header

# third header"
    PRELINE1="# first header"
    PRELINE2=''
    PRELINE3="# third header"
    UPDATE="foo=new"
    run addOrUpdate --pre-line "$PRELINE" --line "$UPDATE" "$FILE"
    [ $status -eq 0 ]
    [ "$output" = "$(cat "$INPUT")
$PRELINE1
$PRELINE2
$PRELINE3
$UPDATE" ]
}

@test "empty pre line" {
    init
    UPDATE="foo=new"
    run addOrUpdate --pre-line '' --line "$UPDATE" "$FILE"
    [ $status -eq 0 ]
    [ "$output" = "$(cat "$INPUT")

$UPDATE" ]
}

@test "single space pre line" {
    init
    PRELINE=" "
    UPDATE="foo=new"
    run addOrUpdate --pre-line "$PRELINE" --line "$UPDATE" "$FILE"
    [ $status -eq 0 ]
    [ "$output" = "$(cat "$INPUT")
$PRELINE
$UPDATE" ]
}

