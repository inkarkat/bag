#!/usr/bin/env bats

load temp

@test "message with single file" {
    init
    UPDATE="foo=new"
    export MEMOIZEDECISION_CHOICE=y
    run containedOrAddOrUpdateLine --in-place --line "$UPDATE" "$FILE"
    [[ "$output" =~ does\ not\ yet\ contain\ \'$UPDATE\'\.\ Shall\ I\ update\ it\? ]]
}

@test "message with multiple files" {
    init
    UPDATE="foo=new"
    export MEMOIZEDECISION_CHOICE=y
    run containedOrAddOrUpdateLine --in-place --line "$UPDATE" "$FILE" "$FILE2" "$FILE3"
    [[ "$output" =~ At\ least\ one\ of\ .*\ does\ not\ yet\ contain\ \'$UPDATE\'\.\ Shall\ I\ update\ it\? ]]
}

@test "--all message with single file" {
    init
    UPDATE="foo=new"
    export MEMOIZEDECISION_CHOICE=y
    run containedOrAddOrUpdateLine --all --in-place --line "$UPDATE" "$FILE"
    [[ "$output" =~ does\ not\ yet\ contain\ \'$UPDATE\'\.\ Shall\ I\ update\ it\? ]]
}

@test "--all message with multiple files" {
    init
    UPDATE="foo=new"
    export MEMOIZEDECISION_CHOICE=y
    run containedOrAddOrUpdateLine --all --in-place --line "$UPDATE" "$FILE" "$FILE2" "$FILE3"
    [[ "$output" =~ All\ of\ .*\ do\ not\ yet\ contain\ \'$UPDATE\'\.\ Shall\ I\ update\ them\? ]]
}

