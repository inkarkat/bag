#!/usr/bin/env bats

load temp

@test "error when combining --in-place and --test-only" {
    init
    export MEMOIZEDECISION_CHOICE=y
    run containedOrAddOrUpdate --in-place --test-only --line new "$FILE"
    [ $status -eq 2 ]
    [ "${lines[1]}" = "ERROR: Cannot combine --in-place and --test-only." ]
    [ "${lines[2]%% *}" = "Usage:" ]
}
