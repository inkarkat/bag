#!/usr/bin/env bats

load fixture

@test "failing to read the database does not run commands, and returns 3" {
    miniDB() {
	contains --query "$@" && return 66 || return 0
    }
    export -f miniDB

    run processAddedFiles --id ID --after --command "printf '[%s]-'"

    [ $status -eq 3 ]
    [ "$output" = "" ]
    assert_args ''
}

@test "failing to update the database returns 3" {
    miniDB() {
	if contains --update "$@"; then
	    return 1
	fi
    }
    export -f miniDB
    LASTFILES='foo\nbar\nwith space'

    run processAddedFiles --id ID --after --command "printf '[%s]-'"

    [ $status -eq 3 ]
    [ "$output" = "[foo]-[bar]-[with space]-" ]
    assert_args '--count 2147483647 --'
}
