#!/bin/bash

export INPUT="${BATS_TEST_DIRNAME}/input.txt"
export MORE2="${BATS_TEST_DIRNAME}/more2.txt"
export MORE3="${BATS_TEST_DIRNAME}/more3.txt"
export FILE="${BATS_TMPDIR}/input.txt"
export FILE2="${BATS_TMPDIR}/more2.txt"
export FILE3="${BATS_TMPDIR}/more3.txt"
init()
{
    cp -f "$INPUT" "$FILE"
    cp -f "$MORE2" "$FILE2"
    cp -f "$MORE3" "$FILE3"
}
