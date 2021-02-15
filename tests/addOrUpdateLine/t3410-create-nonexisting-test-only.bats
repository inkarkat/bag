#!/usr/bin/env bats

@test "test-only update with nonexisting file does not create it" {
    UPDATE="foo=new"
    run addOrUpdateLine --test-only --create-nonexisting --line "$UPDATE" --update-match "foo=bar" "$NONE"
    [ $status -eq 0 ]
    [ "$output" = "" ]
    [ ! -e "$NONE" ]
}

@test "test-only update with all nonexisting files creates none" {
    UPDATE="foo=new"
    run addOrUpdateLine --test-only --create-nonexisting --line "$UPDATE" --update-match "foo=bar" "$NONE" "$NONE2"
    [ $status -eq 0 ]
    [ "$output" = "" ]
    [ ! -e "$NONE" ]
    [ ! -e "$NONE2" ]
}

@test "test-only update with nonexisting first file does not create it" {
    UPDATE="foo=new"
    run addOrUpdateLine --test-only --create-nonexisting --line "$UPDATE" --update-match "foo=bar" "$NONE" "$FILE" "$NONE2" "$FILE2"
    [ $status -eq 0 ]
    [ "$output" = "" ]
    [ ! -e "$NONE" ]
    [ ! -e "$NONE2" ]
}

@test "test-only update with nonexisting files and --all creates none" {
    UPDATE="foo=new"
    run addOrUpdateLine --test-only --create-nonexisting --all --line "$UPDATE" --update-match "foo=bar" "$NONE" "$FILE" "$NONE2" "$FILE2"
    [ $status -eq 0 ]
    [ "$output" = "" ]
    [ ! -e "$NONE" ]
    [ ! -e "$NONE2" ]
}
