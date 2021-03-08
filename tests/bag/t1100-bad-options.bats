#!/usr/bin/env bats

load fixture

@test "the combination of pop and print prints usage error" {
    run bag --pop --print
    [ $status -eq 2 ]
    [ "${lines[2]%% *}" = 'Usage:' ]
}

@test "print does not allow additional arguments" {
    run bag --print -- foo
    [ $status -eq 2 ]
    [ "${lines[2]%% *}" = 'Usage:' ]
}

@test "pop does not allow additional arguments" {
    run bag --pop -- foo
    [ $status -eq 2 ]
    [ "${lines[2]%% *}" = 'Usage:' ]
}

@test "delete does not allow additional arguments" {
    run bag --delete -- foo
    [ $status -eq 2 ]
    [ "${lines[2]%% *}" = 'Usage:' ]
}

@test "cannot combine - with --print" {
    run bag --print -
    [ $status -eq 2 ]
    [ "${lines[2]%% *}" = 'Usage:' ]
}

@test "cannot combine - with --pop" {
    run bag --pop -
    [ $status -eq 2 ]
    [ "${lines[2]%% *}" = 'Usage:' ]
}

@test "cannot combine - with --delete" {
    run bag --delete -
    [ $status -eq 2 ]
    [ "${lines[2]%% *}" = 'Usage:' ]
}

@test "cannot have other arguments after -" {
    run bag - more
    [ $status -eq 2 ]
    [ "${lines[2]%% *}" = 'Usage:' ]
}

@test "cannot combine --lines with --delete" {
    run bag --delete --lines 3
    [ $status -eq 2 ]
    [ "${lines[2]%% *}" = 'Usage:' ]
}

@test "cannot combine --lines with --put" {
    run bag --put --lines 3
    [ $status -eq 2 ]
    [ "${lines[2]%% *}" = 'Usage:' ]
}

@test "cannot combine --lines with collecting stdin" {
    run bag --lines 3
    [ $status -eq 2 ]
    [ "${lines[2]%% *}" = 'Usage:' ]
}
