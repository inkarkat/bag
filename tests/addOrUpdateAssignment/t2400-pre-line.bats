#!/usr/bin/env bats

load temp

@test "append with one pre line" {
    PRELINE="# new header"
    run addOrUpdateAssignment --pre-line "$PRELINE" --lhs new --rhs add "$FILE"
    [ $status -eq 0 ]
    [ "$output" = "$(cat "$INPUT")
$PRELINE
new=add" ]
}

@test "append with three separate pre lines" {
    PRELINE1="# first header"
    PRELINE2=''
    PRELINE3="# third header"
    run addOrUpdateAssignment --pre-line "$PRELINE1" --pre-line "$PRELINE2" --pre-line "$PRELINE3" --lhs new --rhs add "$FILE"
    [ $status -eq 0 ]
    [ "$output" = "$(cat "$INPUT")
$PRELINE1
$PRELINE2
$PRELINE3
new=add" ]
}

@test "append with one multi-line pre line" {
    PRELINE="# first header

# third header"
    PRELINE1="# first header"
    PRELINE2=''
    PRELINE3="# third header"
    run addOrUpdateAssignment --pre-line "$PRELINE" --lhs new --rhs add "$FILE"
    [ $status -eq 0 ]
    [ "$output" = "$(cat "$INPUT")
$PRELINE1
$PRELINE2
$PRELINE3
new=add" ]
}

@test "empty pre line" {
    run addOrUpdateAssignment --pre-line '' --lhs new --rhs add "$FILE"
    [ $status -eq 0 ]
    [ "$output" = "$(cat "$INPUT")

new=add" ]
}

@test "single space pre line" {
    PRELINE=" "
    run addOrUpdateAssignment --pre-line "$PRELINE" --lhs new --rhs add "$FILE"
    [ $status -eq 0 ]
    [ "$output" = "$(cat "$INPUT")
$PRELINE
new=add" ]
}
