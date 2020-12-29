#!/usr/bin/env bats

load temp

@test "error when no LINE passed" {
    run containedOrAddOrUpdateLine "$FILE"
    [ $status -eq 2 ]
    [ "${lines[0]}" = "ERROR: No LINE passed." ]
    [ "${lines[1]%% *}" = "Usage:" ]
}

@test "error when combining --ignore-nonexisting and --create-nonexisting" {
    run containedOrAddOrUpdateLine --ignore-nonexisting --create-nonexisting --line new "$FILE"
    [ $status -eq 2 ]
    [ "${lines[0]}" = "ERROR: Cannot combine --ignore-nonexisting and --create-nonexisting." ]
    [ "${lines[1]%% *}" = "Usage:" ]
}
