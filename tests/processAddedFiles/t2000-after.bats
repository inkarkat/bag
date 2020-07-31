#!/usr/bin/env bats

load fixture

@test "initial call queries all later files and passes to simple command" {
    LASTFILES='foo\nbar\nwith space'
    run processAddedFiles --id ID --after -- printf '[%s]-'

    [ $status -eq 0 ]
    [ "$output" = "[foo]-[bar]-[with space]-" ]
    assert_args '--count 2147483647 --'
    assert_last 'with space'
}

@test "initial call and two later updates, concluded by no further updates and passes to simple command" {
    LASTFILES='foo\nbar\nwith space'
    run processAddedFiles --id ID --after -- printf '[%s]-'

    [ $status -eq 0 ]
    [ "$output" = "[foo]-[bar]-[with space]-" ]
    assert_args '--count 2147483647 --'
    assert_last 'with space'

    LASTFILES='something else'
    run processAddedFiles --id ID --after -- printf '[%s]-'

    [ $status -eq 0 ]
    [ "$output" = "[something else]-" ]
    assert_args '--after with\ space --'
    assert_last 'something else'

    LASTFILES='last\nfiles'
    run processAddedFiles --id ID --after -- printf '[%s]-'

    [ $status -eq 0 ]
    [ "$output" = "[last]-[files]-" ]
    assert_args '--after something\ else --'
    assert_last 'files'

    LASTFILES=''
    run processAddedFiles --id ID --after -- printf '[%s]-'

    [ $status -eq 4 ]
    [ "$output" = "" ]
    assert_args '--after files --'
    assert_last 'files'
}

@test "initial call queries all later files and passes to simple command with explicit {}" {
    LASTFILES='foo\nbar\nwith space'
    run processAddedFiles --id ID --after -- printf '[%s]-' first '{}' last

    [ $status -eq 0 ]
    [ "$output" = "[first]-[foo]-[bar]-[with space]-[last]-" ]
    assert_args '--count 2147483647 --'
    assert_last 'with space'
}

@test "initial call queries later all files and passes to commandline" {
    LASTFILES='foo\nbar\nwith space'
    run processAddedFiles --id ID --after --command "printf '[%s]-'"

    [ $status -eq 0 ]
    [ "$output" = "[foo]-[bar]-[with space]-" ]
    assert_args '--count 2147483647 --'
    assert_last 'with space'
}

@test "initial call queries all later files and passes to commandline with explicit {}" {
    LASTFILES='foo\nbar\nwith space'
    run processAddedFiles --id ID --after --command "printf first-; printf '[%s]-' {}; printf last"

    [ $status -eq 0 ]
    [ "$output" = "first-[foo]-[bar]-[with space]-last" ]
    assert_args '--count 2147483647 --'
}

@test "a failing command gets its exit status returned and does not modify the database" {
    LASTFILES='foo\nbar\nwith space'
    run processAddedFiles --id ID --after -- printf '[%s]-'

    [ $status -eq 0 ]
    [ "$output" = "[foo]-[bar]-[with space]-" ]
    assert_args '--count 2147483647 --'

    LASTFILES='something else'
    run processAddedFiles --id ID --after --command '(printf %s {}; exit 66)'

    [ $status -eq 66 ]
    [ "$output" = "something else" ]
    assert_args '--after with\ space --'
    assert_last 'with space'
}
