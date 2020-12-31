#!/usr/bin/env bats

load temp

@test "update with nonexisting multi-line block from file returns error" {
    run addOrUpdateBlock --marker test --block-file "doesNotExist.txt" "$FILE"
    [ $status -eq 6 ]
    [[ "$output" =~ "doesNotExist.txt: No such file or directory"$ ]]
}
