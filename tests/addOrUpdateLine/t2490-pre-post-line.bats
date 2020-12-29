#!/usr/bin/env bats

load temp

@test "append with pre and post lines" {
    init
    PRELINE1="# new header"
    PRELINE2="more

stuff"
    UPDATE="foo=new"
    POSTLINE1="more

stuff"
    POSTLINE2="# new footer"
    run addOrUpdateLine --pre-line "$PRELINE1" --post-line "$POSTLINE1" --pre-line "$PRELINE2" --post-line "$POSTLINE2" --line "$UPDATE" "$FILE"
    [ "$output" = "$(cat "$INPUT")
$PRELINE1
$PRELINE2
$UPDATE
$POSTLINE1
$POSTLINE2" ]
}
