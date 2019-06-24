#!/usr/bin/env bats

load temp

@test "asks and returns 6 if the update is declined by the user" {
    init
    UPDATE="foo=new"
    export MEMOIZEDECISION_CHOICE=n
    run containedOrAddOrUpdate --in-place --line "$UPDATE" "$FILE"
    [ $status -eq 6 ]
    [[ "$output" =~ does\ not\ yet\ contain\ \'$UPDATE\'\.\ Shall\ I\ update\ it\? ]]
}
