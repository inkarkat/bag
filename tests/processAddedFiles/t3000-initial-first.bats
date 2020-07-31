#!/usr/bin/env bats

load fixture

@test "initial call queries all later files and passes first 2" {
    LASTFILES='one\ntwo\nthree\nfour\nfive'
    run processAddedFiles --id ID --after --initial-first 2 -- printf '[%s]-'

    [ $status -eq 0 ]
    [ "$output" = "[one]-[two]-" ]
    assert_args '--count 2147483647 --'
    assert_last 'two'
}

@test "initial call passes just the first and a later update finds one more" {
    LASTFILES='one\ntwo\nthree'
    run processAddedFiles --id ID --after --initial-first 1 -- printf '[%s]-'

    [ $status -eq 0 ]
    [ "$output" = "[one]-" ]
    assert_args '--count 2147483647 --'
    assert_last 'one'

    LASTFILES='two\nthree\nfour\nfive'
    run processAddedFiles --id ID --after --initial-first 1 -- printf '[%s]-'

    [ $status -eq 0 ]
    [ "$output" = "[two]-[three]-[four]-[five]-" ]
    assert_args '--after one --'
    assert_last 'five'
}

@test "initial call queries all newer files and passes first 2" {
    NEWERFILES='one\ntwo\nthree\nfour\nfive'
    run processAddedFiles --id ID --newer --initial-first 2 -- printf '[%s]-'

    [ $status -eq 0 ]
    [ "$output" = "[one]-[two]-" ]
    assert_args '> --include-epoch --newer-than 0 --'
    assert_last '1002'
}

