#!/bin/bash

export BAG="${BATS_TMPDIR}/bag"

fixtureSetup()
{
    rm -f -- "$BAG"
}
setup()
{
    fixtureSetup
}

assert_no_bag()
{
    [ ! -e "$BAG" ]
}
assert_empty_bag()
{
    [ ! -s "$BAG" ]
}
assert_bag()
{
    if [ "$(cat -- "$BAG")" != "${1?}" ]; then
	dump_bag
	return 1
    fi
}
dump_bag()
{
    cat -- "$BAG" | prefix \# >&3
}
