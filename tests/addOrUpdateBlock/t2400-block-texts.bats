#!/usr/bin/env bats

load temp

@test "update with nonexisting marker and multiple blocks appends the joined block" {
    run addOrUpdateBlock --marker test --block-text "Leading line" --block-text $'several\nlines\nin\nthe\n\nmiddle\n\n' --block-text "Trailing line" "$FILE"
    [ $status -eq 0 ]
    [ "$output" = "$(cat "$FRESH")
# BEGIN test
Leading line
several
lines
in
the

middle


Trailing line
# END test" ]
}
