#!/usr/bin/env bats

@test "no arguments prints message and usage instructions" {
    run processAddedFiles
    [ $status -eq 2 ]
    [ "${lines[0]}" = "ERROR: No -i|--id ID passed." ]
    [ "${lines[1]%% *}" = 'Usage:' ]
}

@test "invalid option prints message and usage instructions" {
    run processAddedFiles --invalid-option
    [ $status -eq 2 ]
    [ "${lines[0]}" = 'ERROR: Unknown option "--invalid-option"!' ]
    [ "${lines[1]%% *}" = 'Usage:' ]
}

@test "missing commands prints message and usage instructions" {
    run processAddedFiles --id ID
    [ $status -eq 2 ]
    [ "${lines[0]}" = 'ERROR: No COMMAND(s) specified; need to pass -c|--command "COMMANDLINE", or SIMPLECOMMAND.' ]
    [ "${lines[1]%% *}" = 'Usage:' ]
}

@test "use of both after and newer prints message and usage instructions" {
    run processAddedFiles --id ID --after --newer
    [ $status -eq 2 ]
    [ "${lines[0]}" = "ERROR: Only one of -a|--after or -N|--newer can be passed." ]
    [ "${lines[1]%% *}" = 'Usage:' ]
}

@test "use of both initial-first and initial-last prints message and usage instructions" {
    run processAddedFiles --id ID --after --initial-first 1 --initial-last 1
    [ $status -eq 2 ]
    [ "${lines[0]}" = "ERROR: Only one of --initial-first or --initial-last can be passed." ]
    [ "${lines[1]%% *}" = 'Usage:' ]
}

@test "use of both max-first and max-last prints message and usage instructions" {
    run processAddedFiles --id ID --after --max-first 1 --max-last 1
    [ $status -eq 2 ]
    [ "${lines[0]}" = "ERROR: Only one of --max-first or --max-last can be passed." ]
    [ "${lines[1]%% *}" = 'Usage:' ]
}
