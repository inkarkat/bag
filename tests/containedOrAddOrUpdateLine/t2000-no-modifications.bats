#!/usr/bin/env bats

load temp

@test "returns 1 if the file already contains the line" {
    init
    run containedOrAddOrUpdateLine --in-place --line "foo=bar" "$FILE"
    [ $status -eq 1 ]
    [ "$output" = "" ]
}

@test "returns 4 if none of the passed files exist" {
    init
    run containedOrAddOrUpdateLine --in-place --line "foo=bar" "$NONE" "$NONE2"
    [ $status -eq 4 ]
    [ "$output" = "" ]
}
