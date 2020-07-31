#!/usr/bin/env bats

load fixture

@test "initial call queries all later files and passes last 2" {
    LASTFILES='one\ntwo\nthree\nfour\nfive'
    run processAddedFiles --id ID --after --initial-last 2 -- printf '[%s]-'

    [ $status -eq 0 ]
    [ "$output" = "[four]-[five]-" ]
    assert_args '--count 2147483647 --'
    assert_last 'five'
}

@test "initial call passes just the last and a later update finds one more" {
    LASTFILES='one\ntwo\nthree'
    run processAddedFiles --id ID --after --initial-last 1 -- printf '[%s]-'

    [ $status -eq 0 ]
    [ "$output" = "[three]-" ]
    assert_args '--count 2147483647 --'
    assert_last 'three'

    LASTFILES='four\nfive'
    run processAddedFiles --id ID --after --initial-last 1 -- printf '[%s]-'

    [ $status -eq 0 ]
    [ "$output" = "[four]-[five]-" ]
    assert_args '--after three --'
    assert_last 'five'
}

@test "initial call queries all newer files and passes last 2" {
    NEWERFILES='one\ntwo\nthree\nfour\nfive'
    run processAddedFiles --id ID --newer --initial-last 2 -- printf '[%s]-'

    [ $status -eq 0 ]
    [ "$output" = "[four]-[five]-" ]
    assert_args '> --include-epoch --newer-than 0 --'
    assert_last '1005'
}

