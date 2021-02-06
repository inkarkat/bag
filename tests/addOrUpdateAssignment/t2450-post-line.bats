#!/usr/bin/env bats

load temp

@test "append with one post line" {
    POSTLINE="# new footer"
    run addOrUpdateAssignment --post-line "$POSTLINE" --lhs new --rhs add "$FILE"
    [ $status -eq 0 ]
    [ "$output" = "$(cat "$INPUT")
new=add
$POSTLINE" ]
}

@test "append with three separate post lines" {
    POSTLINE1="# first footer"
    POSTLINE2=''
    POSTLINE3="# third footer"
    run addOrUpdateAssignment --post-line "$POSTLINE1" --post-line "$POSTLINE2" --post-line "$POSTLINE3" --lhs new --rhs add "$FILE"
    [ $status -eq 0 ]
    [ "$output" = "$(cat "$INPUT")
new=add
$POSTLINE1
$POSTLINE2
$POSTLINE3" ]
}

@test "append with one multi-line post line" {
    POSTLINE="# first footer

# third footer"
    POSTLINE1="# first footer"
    POSTLINE2=''
    POSTLINE3="# third footer"
    run addOrUpdateAssignment --post-line "$POSTLINE" --lhs new --rhs add "$FILE"
    [ $status -eq 0 ]
    [ "$output" = "$(cat "$INPUT")
new=add
$POSTLINE1
$POSTLINE2
$POSTLINE3" ]
}

addOrUpdateLineWithPeriod()
{
    addOrUpdateAssignment "$@"; printf .
}
@test "empty post line" {
    run addOrUpdateLineWithPeriod --post-line '' --lhs new --rhs add "$FILE"
    [ $status -eq 0 ]
    [ "${output}" = "$(cat "$INPUT")
new=add

." ]
}

@test "single space post line" {
    POSTLINE=" "
    run addOrUpdateLineWithPeriod --post-line "$POSTLINE" --lhs new --rhs add "$FILE"
    [ $status -eq 0 ]
    [ "${output}" = "$(cat "$INPUT")
new=add
${POSTLINE}
." ]
}
