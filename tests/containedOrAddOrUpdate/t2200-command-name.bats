#!/usr/bin/env bats

load temp

@test "asks with custom command name" {
    init
    NAME="My test file"
    UPDATE="foo=new"
    export MEMOIZEDECISION_CHOICE=n
    run containedOrAddOrUpdate --command-name "$NAME" --in-place --line "$UPDATE" "$FILE"
    [[ "$output" =~ ${NAME}\ does\ not\ yet\ contain\ \'$UPDATE\'\.\ Shall\ I\ update\ it\? ]]
}
