#!/usr/bin/env bats

load fixture

@test "the combination of pop and print prints usage error" {
    run bag --pop --print
    [ $status -eq 2 ]
    [ "${lines[4]%% *}" = 'Usage:' ]
}

@test "print does not allow additional arguments" {
    run bag --print -- foo
    [ $status -eq 2 ]
    [ "${lines[4]%% *}" = 'Usage:' ]
}

@test "pop does not allow additional arguments" {
    run bag --pop -- foo
    [ $status -eq 2 ]
    [ "${lines[4]%% *}" = 'Usage:' ]
}

@test "delete does not allow additional arguments" {
    run bag --delete -- foo
    [ $status -eq 2 ]
    [ "${lines[4]%% *}" = 'Usage:' ]
}
