#!/usr/bin/env bats

load fixture

@test "appending an empty line" {
    echo 'first entry' | bag
    echo | bag --append
    echo 'last entry' | bag --append

    assert_bag "first entry

last entry"
}

@test "appending nothing does not change the bag" {
    echo 'first entry' | bag
    printf '' | bag --append
    echo 'last entry' | bag --append

    assert_bag "first entry
last entry"
}

@test "appending an imcomplete line" {
    echo 'first entry' | bag
    printf 'this is incomplete:' | bag --append
    echo 'last entry' | bag --append

    assert_bag "first entry
this is incomplete:last entry"
}
