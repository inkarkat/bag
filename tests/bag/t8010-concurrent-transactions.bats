#!/usr/bin/env bats

load fixture
load concurrent

@test "$CONCURRENT_NUMBER concurrent transactional pops do not lose any lines" {
    fill_bag

    for ((i = 0; i < $CONCURRENT_NUMBER; i++))
    do
	(
	    for ((j = 0; j < $POP_NUMBER; j++))
	    do
		bag --transactional --pop --lines $POP_AMOUNT >/dev/null
	    done
	) &
    done

    wait
    assert_bag_lines -eq $((100000 - CONCURRENT_NUMBER * POP_NUMBER * POP_AMOUNT))
}
