#!/usr/bin/env bats

load fixture

@test "a passed argument creates the bag" {
    bag 'first entry'

    assert_bag "first entry"
}

@test "a passed argument works when stdin is from terminal" {
    { exec </dev/tty; } 2>/dev/null || skip 'cannot access terminal'

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

@test "prepending an argument" {
    bag 'first entry'
    bag --prepend 'second entry'

    assert_bag "second entry
first entry"
}

@test "prepending three arguments" {
    bag 'first entry'
    bag --prepend 'second entry' 'third entry' 'last entry'

    assert_bag "second entry
third entry
last entry
first entry"
}

@test "three passed arguments create three lines" {
    bag 'first entry' 'second entry' 'last entry'

    assert_bag "first entry
second entry
last entry"
}
