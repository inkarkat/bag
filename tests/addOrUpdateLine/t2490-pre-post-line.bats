#!/usr/bin/env bats

load temp

@test "append with pre and post lines" {
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

@test "append with pre and post lines that contain backslashes" {
    PRELINE='/new header\'
    UPDATE="foo=new"
    POSTLINE='\new footer/'
    run addOrUpdateLine --pre-line "$PRELINE" --post-line "$POSTLINE" --line "$UPDATE" "$FILE"
    [ "$output" = "$(cat "$INPUT")
$PRELINE
$UPDATE
$POSTLINE" ]
}
