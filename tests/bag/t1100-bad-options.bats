#!/usr/bin/env bats

load fixture

@test "missing -- when putting prints usage error" {
    [ -t 0 ] || skip 'Not reading from terminal'
    run -2 bag 'first entry'
    assert_line -n 2 -e '^Usage:'
}

@test "the combination of pop and print prints usage error" {
    run -2 bag --pop --print
    assert_line -n 2 -e '^Usage:'
}

@test "print does not allow additional arguments" {
    run -2 bag --print -- foo
    assert_line -n 2 -e '^Usage:'
}

@test "pop does not allow additional arguments" {
    run -2 bag --pop -- foo
    assert_line -n 2 -e '^Usage:'
}

@test "delete does not allow additional arguments" {
    run -2 bag --delete -- foo
    assert_line -n 2 -e '^Usage:'
}

@test "cannot combine - with --print" {
    run -2 bag --print -
    assert_line -n 2 -e '^Usage:'
}

@test "cannot combine - with --pop" {
    run -2 bag --pop -
    assert_line -n 2 -e '^Usage:'
}

@test "cannot combine - with --delete" {
    run -2 bag --delete -
    assert_line -n 2 -e '^Usage:'
}

@test "cannot have other arguments after -" {
    run -2 bag - more
    assert_line -n 2 -e '^Usage:'
}

@test "cannot combine --lines with --delete" {
    run -2 bag --delete --lines 3
    assert_line -n 2 -e '^Usage:'
}

@test "cannot combine --lines with --put" {
    run -2 bag --put --lines 3
    assert_line -n 2 -e '^Usage:'
}

@test "cannot combine --lines with collecting stdin" {
    run -2 bag --lines 3 </dev/null
    assert_line -n 2 -e '^Usage:'
}
