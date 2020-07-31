#!/usr/bin/env bats

load fixture

@test "initial call queries all newer files and passes to simple command" {
    NEWERFILES='foo\nbar\nwith space'
    run processAddedFiles --id ID --newer -- printf '[%s]-'

    [ $status -eq 0 ]
    [ "$output" = "[foo]-[bar]-[with space]-" ]
    assert_args '> --include-epoch --newer-than 0 --'
    assert_last 1003
}

@test "initial call and two newer updates, concluded by no further updates and passes to simple command" {
    NEWERFILES='foo\nbar\nwith space'
    run processAddedFiles --id ID --newer -- printf '[%s]-'

    [ $status -eq 0 ]
    [ "$output" = "[foo]-[bar]-[with space]-" ]
    assert_args '> --include-epoch --newer-than 0 --'
    assert_last 1003

    NEWERFILES='something else'
    run processAddedFiles --id ID --newer -- printf '[%s]-'

    [ $status -eq 0 ]
    [ "$output" = "[something else]-" ]
    assert_args '> --include-epoch --newer-than 1003 --'
    assert_last 1001

    NEWERFILES='last\nfiles'
    run processAddedFiles --id ID --newer -- printf '[%s]-'

    [ $status -eq 0 ]
    [ "$output" = "[last]-[files]-" ]
    assert_args '> --include-epoch --newer-than 1001 --'
    assert_last 1002

    NEWERFILES=''
    run processAddedFiles --id ID --newer -- printf '[%s]-'

    [ $status -eq 4 ]
    [ "$output" = "" ]
    assert_args '> --include-epoch --newer-than 1002 --'
    assert_last 1002
}
