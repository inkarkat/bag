#!/usr/bin/env bats

load temp

@test "error when no LINE passed" {
    run addOrUpdate "$FILE"
    [ $status -eq 2 ]
    [ "${lines[0]}" = "ERROR: No LINE passed." ]
    [ "${lines[1]%% *}" = "Usage:" ]
}

@test "error when combining --in-place and --test-only" {
    run addOrUpdate --in-place --test-only --line new "$FILE"
    [ $status -eq 2 ]
    [ "${lines[0]}" = "ERROR: Cannot combine --in-place and --test-only." ]
    [ "${lines[1]%% *}" = "Usage:" ]
}
