#!/usr/bin/env bats

load temp

@test "error when no BLOCK passed" {
    run addOrUpdateBlock --marker test "$FILE"
    [ $status -eq 2 ]
    [ "${lines[0]}" = "ERROR: No BLOCK passed; use either -b|--block-text BLOCK-TEXT or -B|--block-file BLOCK-FILE." ]
    [ "${lines[1]%% *}" = "Usage:" ]
}

@test "error when no marker passed" {
    run addOrUpdateBlock --block-text $'new\nblock' "$FILE"
    [ $status -eq 2 ]
    [ "${lines[0]}" = "ERROR: No BEGIN-LINE; use either --begin-marker BEGIN-LINE or -m|--marker WHAT." ]
    [ "${lines[1]%% *}" = "Usage:" ]
}

@test "error when no end marker passed" {
    run addOrUpdateBlock --begin-marker START --block-text $'new\nblock' "$FILE"
    [ $status -eq 2 ]
    [ "${lines[0]}" = "ERROR: No END-LINE; use --end-marker END-LINE." ]
    [ "${lines[1]%% *}" = "Usage:" ]
}

@test "error when combining --in-place and --test-only" {
    run addOrUpdateBlock --in-place --test-only --marker test --block-text $'new\nblock' "$FILE"
    [ $status -eq 2 ]
    [ "${lines[0]}" = "ERROR: Cannot combine --in-place and --test-only." ]
    [ "${lines[1]%% *}" = "Usage:" ]
}

@test "error when combining --ignore-nonexisting and --create-nonexisting" {
    run addOrUpdateBlock --ignore-nonexisting --create-nonexisting --marker test --block-text $'new\nblock' "$FILE"
    [ $status -eq 2 ]
    [ "${lines[0]}" = "ERROR: Cannot combine --ignore-nonexisting and --create-nonexisting." ]
    [ "${lines[1]%% *}" = "Usage:" ]
}
