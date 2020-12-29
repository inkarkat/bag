#!/usr/bin/env bats

load temp

@test "append with one post line" {
    init
    POSTLINE="# new footer"
    UPDATE="foo=new"
    run addOrUpdateLine --post-line "$POSTLINE" --line "$UPDATE" "$FILE"
    [ $status -eq 0 ]
    [ "$output" = "$(cat "$INPUT")
$UPDATE
$POSTLINE" ]
}

@test "append with three separate post lines" {
    init
    POSTLINE1="# first footer"
    POSTLINE2=''
    POSTLINE3="# third footer"
    UPDATE="foo=new"
    run addOrUpdateLine --post-line "$POSTLINE1" --post-line "$POSTLINE2" --post-line "$POSTLINE3" --line "$UPDATE" "$FILE"
    [ $status -eq 0 ]
    [ "$output" = "$(cat "$INPUT")
$UPDATE
$POSTLINE1
$POSTLINE2
$POSTLINE3" ]
}

@test "append with one multi-line post line" {
    init
    POSTLINE="# first footer

# third footer"
    POSTLINE1="# first footer"
    POSTLINE2=''
    POSTLINE3="# third footer"
    UPDATE="foo=new"
    run addOrUpdateLine --post-line "$POSTLINE" --line "$UPDATE" "$FILE"
    [ $status -eq 0 ]
    [ "$output" = "$(cat "$INPUT")
$UPDATE
$POSTLINE1
$POSTLINE2
$POSTLINE3" ]
}

addOrUpdateLineWithPeriod()
{
    addOrUpdateLine "$@"; printf .
}
@test "empty post line" {
    init
    UPDATE="foo=new"
    run addOrUpdateLineWithPeriod --post-line '' --line "$UPDATE" "$FILE"
    [ $status -eq 0 ]
    [ "${output}" = "$(cat "$INPUT")
$UPDATE

." ]
}

@test "single space post line" {
    init
    POSTLINE=" "
    UPDATE="foo=new"
    run addOrUpdateLineWithPeriod --post-line "$POSTLINE" --line "$UPDATE" "$FILE"
    [ $status -eq 0 ]
    [ "${output}" = "$(cat "$INPUT")
$UPDATE
${POSTLINE}
." ]
}

