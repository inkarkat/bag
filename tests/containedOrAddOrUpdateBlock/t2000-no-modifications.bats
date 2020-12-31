#!/usr/bin/env bats

load temp

@test "returns 1 if the file already contains the line" {
    run containedOrAddOrUpdateBlock --in-place --marker subsequent --block-text "Single line" "$FILE2"
    [ $status -eq 1 ]
    [ "$output" = "" ]
}

@test "returns 4 if none of the passed files exist" {
    run containedOrAddOrUpdateBlock --in-place --marker test --block-text new "$NONE" "$NONE2"
    [ $status -eq 4 ]
    [ "$output" = "" ]
}
