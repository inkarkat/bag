#!/usr/bin/env bats

load fixture
load concurrent

@test "$CONCURRENT_NUMBER concurrent non-transactional pops fail to remove some lines" {
    fill_bag

    for ((i = 0; i < $CONCURRENT_NUMBER; i++))
    do
	(
	    for ((j = 0; j < $POP_NUMBER; j++))
	    do
		bag --pop --lines $POP_AMOUNT >/dev/null
	    done
	) &
    done

    wait
    assert_bag_lines -gt $((100000 - CONCURRENT_NUMBER * POP_NUMBER * POP_AMOUNT))
}
