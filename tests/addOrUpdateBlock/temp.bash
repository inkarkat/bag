#!/bin/bash

export FRESH="${BATS_TEST_DIRNAME}/fresh.txt"
export EXISTING="${BATS_TEST_DIRNAME}/existing.txt"
export BAD="${BATS_TEST_DIRNAME}/bad.txt"
export FILE="${BATS_TMPDIR}/fresh.txt"
export FILE2="${BATS_TMPDIR}/existing.txt"
export FILE3="${BATS_TMPDIR}/bad.txt"
export NONE="${BATS_TMPDIR}/none.txt"
export NONE2="${BATS_TMPDIR}/none2.txt"
init()
{
    cp -f "$FRESH" "$FILE"
    cp -f "$EXISTING" "$FILE2"
    cp -f "$BAD" "$FILE3"
    rm -f "$NONE" "$NONE2" 2>/dev/null
}
