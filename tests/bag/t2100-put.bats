#!/usr/bin/env bats

load fixture

@test "a passed argument creates the bag" {
    bag 'first entry'

    assert_bag "first entry"
}

@test "a second argument overwrites the bag" {
    bag -- 'second entry'

    assert_bag "second entry"
}

@test "putting an argument with newlines" {
    bag -- "this entry
 has
multiple lines"

    assert_bag "this entry
 has
multiple lines"
}

@test "appending an argument" {
    bag 'first entry'
    bag --append 'second entry'

    assert_bag "first entry
second entry"
}
