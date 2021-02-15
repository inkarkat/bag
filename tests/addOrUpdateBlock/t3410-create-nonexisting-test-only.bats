#!/usr/bin/env bats

@test "test-only update with nonexisting file does not create it" {
    run addOrUpdateBlock --test-only --create-nonexisting --marker test --block-text "$TEXT" "$NONE"
    [ $status -eq 0 ]
    [ "$output" = "" ]
    [ ! -e "$NONE" ]
}

@test "test-only update with all nonexisting files creates none" {
    run addOrUpdateBlock --test-only --create-nonexisting --marker test --block-text "$TEXT" "$NONE" "$NONE2"
    [ $status -eq 0 ]
    [ "$output" = "" ]
    [ ! -e "$NONE" ]
    [ ! -e "$NONE2" ]
}

@test "test-only update with nonexisting first file does not create it" {
    run addOrUpdateBlock --test-only --create-nonexisting --marker test --block-text "$TEXT" "$NONE" "$FILE" "$NONE2" "$FILE2"
    [ $status -eq 0 ]
    [ "$output" = "" ]
    [ ! -e "$NONE" ]
    [ ! -e "$NONE2" ]
}

@test "test-only update with nonexisting files and --all creates and appends each" {
    run addOrUpdateBlock --test-only --create-nonexisting --all --marker test --block-text "$TEXT" "$NONE" "$FILE" "$NONE2" "$FILE2"
    [ $status -eq 0 ]
    [ "$output" = "" ]
    [ ! -e "$NONE" ]
    [ ! -e "$NONE2" ]
}
