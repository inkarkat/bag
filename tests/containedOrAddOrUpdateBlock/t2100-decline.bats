#!/usr/bin/env bats

load temp

@test "asks and returns 99 if the update is declined by the user" {
    export MEMOIZEDECISION_CHOICE=n
    run containedOrAddOrUpdateBlock --in-place --marker test --block-text new "$FILE2"
    [ $status -eq 99 ]
    [[ "$output" =~ does\ not\ yet\ contain\ test\.\ Shall\ I\ update\ it\? ]]
}
