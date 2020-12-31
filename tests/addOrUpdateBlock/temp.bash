#!/bin/bash

export FRESH="${BATS_TEST_DIRNAME}/fresh.txt"
export EXISTING="${BATS_TEST_DIRNAME}/existing.txt"
export ANOTHER="${BATS_TEST_DIRNAME}/another.txt"
export FILE="${BATS_TMPDIR}/fresh.txt"
export FILE2="${BATS_TMPDIR}/existing.txt"
export FILE3="${BATS_TMPDIR}/another.txt"
export NONE="${BATS_TMPDIR}/none.txt"
export NONE2="${BATS_TMPDIR}/none2.txt"

tempSetup()
{
    cp -f "$FRESH" "$FILE"
    cp -f "$EXISTING" "$FILE2"
    cp -f "$ANOTHER" "$FILE3"
    rm -f "$NONE" "$NONE2" 2>/dev/null
}
setup()
{
    tempSetup
}
