#!/usr/bin/env bats

load temp

@test "error when no LINE passed" {
    run addOrUpdateLine "$FILE"
    [ $status -eq 2 ]
    [ "${lines[0]}" = "ERROR: No LINE passed." ]
    [ "${lines[1]%% *}" = "Usage:" ]
}

@test "error when combining --in-place and --test-only" {
    run addOrUpdateLine --in-place --test-only --line new "$FILE"
    [ $status -eq 2 ]
    [ "${lines[0]}" = "ERROR: Cannot combine --in-place and --test-only." ]
    [ "${lines[1]%% *}" = "Usage:" ]
}

@test "error when combining --ignore-nonexisting and --create-nonexisting" {
    run addOrUpdateLine --ignore-nonexisting --create-nonexisting --line new "$FILE"
    [ $status -eq 2 ]
    [ "${lines[0]}" = "ERROR: Cannot combine --ignore-nonexisting and --create-nonexisting." ]
    [ "${lines[1]%% *}" = "Usage:" ]
}

@test "error when combining --add-before and --add-after" {
    run addOrUpdateLine --add-before 4 --add-after 6 --line new "$FILE"
    [ $status -eq 2 ]
    [ "${lines[0]}" = "ERROR: Cannot combine --add-before and --add-after." ]
    [ "${lines[1]%% *}" = "Usage:" ]
}
