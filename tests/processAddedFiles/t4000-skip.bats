#!/usr/bin/env bats

load fixture

@test "initial call skips after files matching glob" {
    LASTFILES='foo\nbar\nfff\nbaz\nwith space\nfor\nfox'
    run processAddedFiles --id ID --after --skip 'f??' -- printf '[%s]-'

    [ $status -eq 0 ]
    [ "$output" = "[bar]-[baz]-[with space]-" ]
    assert_args '--count 2147483647 --'
    assert_last 'with space'
}

@test "initial call returns 4 when all after files match glob" {
    LASTFILES='foo\nbar\nfff\nbaz\nwith space\nfor\nfox'
    run processAddedFiles --id ID --after --skip '*' -- printf '[%s]-'

    [ $status -eq 4 ]
    [ "$output" = "" ]
    assert_args '--count 2147483647 --'
    assert_last ''
}

@test "initial call skips newer files matching glob" {
    NEWERFILES='foo\nbar\nfff\nbaz\nwith space\nfor\nfox'
    run processAddedFiles --id ID --newer --skip 'f??' -- printf '[%s]-'

    [ $status -eq 0 ]
    [ "$output" = "[bar]-[baz]-[with space]-" ]
    assert_args '> --include-epoch --newer-than 0 --'
    assert_last 1005
}

@test "initial call returns 4 when all newer files match glob" {
    NEWERFILES='foo\nbar\nfff\nbaz\nwith space\nfor\nfox'
    run processAddedFiles --id ID --newer --skip '*[fbw]*' -- printf '[%s]-'

    [ $status -eq 4 ]
    [ "$output" = "" ]
    assert_args '> --include-epoch --newer-than 0 --'
    assert_last ''
}
