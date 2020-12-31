#!/usr/bin/env bats

load temp

@test "error when combining --in-place and --test-only" {
    export MEMOIZEDECISION_CHOICE=y
    run containedOrAddOrUpdateBlock --in-place --test-only --marker test --block-text new "$FILE"
    [ $status -eq 2 ]
    [ "${lines[1]}" = "ERROR: Cannot combine --in-place and --test-only." ]
    [ "${lines[2]%% *}" = "Usage:" ]
}
