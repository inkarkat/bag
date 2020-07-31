#!/usr/bin/env bats

load fixture

@test "when the second update has no newer results, 4 is returned immediately without another initial call" {
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

    NEWERFILES=''
    run processAddedFiles --id ID --newer -- printf '[%s]-'

    NEWERFILES_EXIT=4
    [ "$output" = "" ]
    assert_args '> --include-epoch --newer-than 1001 --'
    assert_last 1001
}


