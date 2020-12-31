#!/usr/bin/env bats

load temp

@test "error when no block passed" {
    run containedOrAddOrUpdateBlock "$FILE"
    [ $status -eq 2 ]
    [ "${lines[0]}" = "ERROR: No BLOCK passed; use either -b|--block-text BLOCK-TEXT or -B|--block-file BLOCK-FILE." ]
    [ "${lines[1]%% *}" = "Usage:" ]
}

@test "error when combining --ignore-nonexisting and --create-nonexisting" {
    run containedOrAddOrUpdateBlock --ignore-nonexisting --create-nonexisting --marker test --block-text new "$FILE"
    [ $status -eq 2 ]
    [ "${lines[0]}" = "ERROR: Cannot combine --ignore-nonexisting and --create-nonexisting." ]
    [ "${lines[1]%% *}" = "Usage:" ]
}
