#!/bin/bash

fill_bag()
{
    seq 1 100000 > "$BAG"
}

assert_bag_lines()
{
    total="$(bag --print | wc -l)"
    [ "$DEBUG" ] && echo >&3 "# total lines: $total; expected: ${!#}"
    [ $total "$@" ]
}

CONCURRENT_NUMBER=5
POP_NUMBER=3
POP_AMOUNT=10
