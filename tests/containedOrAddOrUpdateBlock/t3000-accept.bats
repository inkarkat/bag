#!/usr/bin/env bats

load temp

@test "asks, appends, and returns 0 if the update is accepted by the user" {
    export MEMOIZEDECISION_CHOICE=y
    run containedOrAddOrUpdateBlock --in-place --marker test --block-text "$TEXT" "$FILE"
    [ $status -eq 0 ]
    [[ "$output" =~ does\ not\ yet\ contain\ test\.\ Shall\ I\ update\ it\? ]]
    [ "$(cat "$FILE")" = "$(cat "$FRESH")
$BLOCK" ]
}

@test "asks, updates, and returns 0 if the update is accepted by the user" {
    export MEMOIZEDECISION_CHOICE=y
    run containedOrAddOrUpdateBlock --in-place --marker test --block-text "$TEXT" "$FILE3"
    [ $status -eq 0 ]
    [[ "$output" =~ does\ not\ yet\ contain\ test\.\ Shall\ I\ update\ it\? ]]
    [ "$(cat "$FILE3")" = "$BLOCK" ]
}
