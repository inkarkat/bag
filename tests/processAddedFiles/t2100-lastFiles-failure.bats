#!/usr/bin/env bats

load fixture

@test "failing to retrieve the initial files does not modify the database, not run commands, and returns 4" {
    LASTFILES_EXIT=1
    run processAddedFiles --id ID --after -- printf '[%s]-'

    [ $status -eq 4 ]
    [ "$output" = "" ]
    assert_args '--count 2147483647 --'
    assert_last ''
}

@test "retrieving no initial files does not modify the database, not run commands, and returns 4" {
    LASTFILES=''
    run processAddedFiles --id ID --after -- printf '[%s]-'

    [ $status -eq 4 ]
    [ "$output" = "" ]
    assert_args '--count 2147483647 --'
    assert_last ''
}

@test "failing to retrieve later files does not modify the database, not run commands, and returns 4" {
    LASTFILES='foo\nbar\nwith space'
    run processAddedFiles --id ID --after -- printf '[%s]-'

    [ $status -eq 0 ]
    [ "$output" = "[foo]-[bar]-[with space]-" ]
    assert_args '--count 2147483647 --'
    assert_last 'with space'

    LASTFILES_EXIT=1
    LASTFILES=''
    run processAddedFiles --id ID --after -- printf '[%s]-'

    [ $status -eq 4 ]
    [ "$output" = "" ]
    assert_args '--after with\ space --'
    assert_last 'with space'
}

@test "retrieving no later files does not modify the database, not run commands, and returns 4" {
    LASTFILES='foo\nbar\nwith space'
    run processAddedFiles --id ID --after -- printf '[%s]-'

    [ $status -eq 0 ]
    [ "$output" = "[foo]-[bar]-[with space]-" ]
    assert_args '--count 2147483647 --'
    assert_last 'with space'

    LASTFILES=''
    run processAddedFiles --id ID --after -- printf '[%s]-'

    [ $status -eq 4 ]
    [ "$output" = "" ]
    assert_args '--after with\ space --'
    assert_last 'with space'
}
