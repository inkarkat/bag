#!/usr/bin/env bats

@test "update of block without end marker appends the block" {
    run addOrUpdateBlock --marker 'without end' --block-text "UPDATE" "${BATS_TEST_DIRNAME}/no-end.txt"
    [ $status -eq 0 ]
    [ "$output" = "one
two
# BEGIN without end
what
here
# BEGIN without end
UPDATE
# END without end" ]
}

@test "update of block with repeated begin updates from the second begin only" {
    run addOrUpdateBlock --marker repeated --block-text "UPDATE" "${BATS_TEST_DIRNAME}/repeated-begin.txt"
    [ $status -eq 0 ]
    [ "$output" = "one
two
# BEGIN repeated
hello
# BEGIN repeated
UPDATE
# END repeated
last" ]
}

@test "update of block with repeasted end updates to the first end only" {
    run addOrUpdateBlock --marker repeated --block-text "UPDATE" "${BATS_TEST_DIRNAME}/repeated-end.txt"
    [ $status -eq 0 ]
    [ "$output" = "one
two
# BEGIN repeated
UPDATE
# END repeated
good morning
# END repeated
last" ]
}
