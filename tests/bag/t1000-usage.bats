#!/usr/bin/env bats

load fixture

@test "invalid option prints message and usage instructions" {
  run bag --invalid-option
    [ $status -eq 2 ]
    [ "${lines[0]}" = 'ERROR: Unknown option "--invalid-option"!' ]
    [ "${lines[2]%% *}" = 'Usage:' ]
}

@test "-h prints long usage help" {
  run bag -h
    [ $status -eq 0 ]
    [ "${lines[0]%% *}" != 'Usage:' ]
}
