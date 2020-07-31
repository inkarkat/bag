#!/usr/bin/env bats

load fixture

@test "initial call queries all files and passes to simple command" {
    LASTFILES='foo\nbar\nwith space'
    run processAddedFiles --id ID --after -- printf '[%s]-'

    [ $status -eq 0 ]
    [ "$output" = "[foo]-[bar]-[with space]-" ]
    assert_args '--count 2147483647 --'
}

@test "initial call and two updates, concluded by no further updates and passes to simple command" {
    LASTFILES='foo\nbar\nwith space'
    run processAddedFiles --id ID --after -- printf '[%s]-'

    [ $status -eq 0 ]
    [ "$output" = "[foo]-[bar]-[with space]-" ]
    assert_args '--count 2147483647 --'

    LASTFILES='something else'
    run processAddedFiles --id ID --after -- printf '[%s]-'

    [ $status -eq 0 ]
    [ "$output" = "[something else]-" ]
    assert_args '--after with\ space --'

    LASTFILES='last\nfiles'
    run processAddedFiles --id ID --after -- printf '[%s]-'

    [ $status -eq 0 ]
    [ "$output" = "[last]-[files]-" ]
    assert_args '--after something\ else --'

    LASTFILES=''
    run processAddedFiles --id ID --after -- printf '[%s]-'

    [ $status -eq 4 ]
    [ "$output" = "" ]
    assert_args '--after files --'
}

@test "initial call queries all files and passes to simple command with explicit {}" {
    LASTFILES='foo\nbar\nwith space'
    run processAddedFiles --id ID --after -- printf '[%s]-' first '{}' last

    [ $status -eq 0 ]
    [ "$output" = "[first]-[foo]-[bar]-[with space]-[last]-" ]
    assert_args '--count 2147483647 --'
}

@test "initial call queries all files and passes to commandline" {
    LASTFILES='foo\nbar\nwith space'
    run processAddedFiles --id ID --after --command "printf '[%s]-'"

    [ $status -eq 0 ]
    [ "$output" = "[foo]-[bar]-[with space]-" ]
    assert_args '--count 2147483647 --'
}

@test "initial call queries all files and passes to commandline with explicit {}" {
    LASTFILES='foo\nbar\nwith space'
    run processAddedFiles --id ID --after --command "printf first-; printf '[%s]-' {}; printf last"

    [ $status -eq 0 ]
    [ "$output" = "first-[foo]-[bar]-[with space]-last" ]
    assert_args '--count 2147483647 --'
}
