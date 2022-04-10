#!/bin/bash

export BAG="${BATS_TMPDIR}/bag"

fixtureSetup()
{
    rm -f -- "$BAG" "${BAG}.bak"
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
    [ -e "$BAG" -a  ! -s "$BAG" ]
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
    prefix '#' "$BAG" >&3
}

make_bag()
{
    echo -e 'some stuff\n in\nhere' | bag
}
