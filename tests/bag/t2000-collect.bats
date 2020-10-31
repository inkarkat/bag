#!/usr/bin/env bats

load fixture

@test "a piped line creates the bag" {
    echo 'first entry' | bag

    assert_bag "first entry"
}

@test "a second set of lines overwrites the bag" {
    echo 'first entry' | bag
    echo -e 'second entry\nand more' | bag

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
