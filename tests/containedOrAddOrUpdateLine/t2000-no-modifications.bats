#!/usr/bin/env bats

load temp

@test "returns 1 and error message if the file already contains the line" {
    init
    run containedOrAddOrUpdateLine --in-place --line "foo=bar" "$FILE"
    [ $status -eq 1 ]
    [ "$output" = "$FILE already contains 'foo=bar'; no update necessary." ]
}

@test "returns 1 and error message mentioning the name if the file already contains the line" {
    init
    NAME="My test file"
    run containedOrAddOrUpdateLine --in-place --name "$NAME" --line "foo=bar" "$FILE"
    [ $status -eq 1 ]
    [ "$output" = "$NAME already contains 'foo=bar'; no update necessary." ]
}

@test "returns 4 if none of the passed files exist" {
    init
    run containedOrAddOrUpdateLine --in-place --line "foo=bar" "$NONE" "$NONE2"
    [ $status -eq 4 ]
    [ "$output" = "" ]
}
