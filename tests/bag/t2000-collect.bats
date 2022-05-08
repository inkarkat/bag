#!/usr/bin/env bats

load fixture

@test "a piped line creates the bag" {
    echo 'first entry' | bag

    assert_bag "first entry"
}

@test "appending a line creates the bag" {
    bag --append 'first entry'

    assert_bag "first entry"
}

@test "appending a line to an empty bag" {
    empty_bag
    bag --append 'first entry'

    assert_bag "first entry"
}

@test "prepending a line creates the bag" {
    bag --prepend 'first entry'

    assert_bag "first entry"
}

@test "prepending a line to an empty bag" {
    empty_bag
    bag --prepend 'first entry'

    assert_bag "first entry"
}

@test "a second set of lines overwrites the bag" {
    echo 'first entry' | bag
    echo -e 'second entry\nand more' | bag

    assert_bag "second entry
and more"
}

@test "a second set of lines with set action overwrites the bag" {
    echo 'first entry' | bag
    echo -e 'second entry\nand more' | bag set

    assert_bag "second entry
and more"
}

@test "appending additional lines" {
    echo -e 'first entry\nsecond entry\nand more' | bag
    echo -e 'third entry\ngets appended' | bag --append

    assert_bag "first entry
second entry
and more
third entry
gets appended"
}

@test "appending additional lines with add action" {
    echo -e 'first entry\nsecond entry\nand more' | bag
    echo -e 'third entry\ngets appended' | bag add

    assert_bag "first entry
second entry
and more
third entry
gets appended"
}

@test "prepending additional lines" {
    echo -e 'first entry\nsecond entry\nand more' | bag
    echo -e 'third entry\ngets prepended' | bag --prepend

    assert_bag "third entry
gets prepended
first entry
second entry
and more"
}

@test "force reading from stdin via -" {
    echo 'first entry' | bag -

    assert_bag "first entry"
}
