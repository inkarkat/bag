#!/usr/bin/env bats

load fixture

@test "the combination of pop and print prints usage error" {
    run bag --pop --print
    [ $status -eq 2 ]
    [ "${lines[3]%% *}" = 'Usage:' ]
}
