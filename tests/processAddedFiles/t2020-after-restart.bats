#!/usr/bin/env bats

load fixture

lastFiles()
{
    { printf '%q ' "$@"; printf \\n; } > "$ARG_FILESPEC"

    local lastFiles="$(pop --delete "${BATS_TMPDIR}/lastFiles")"
    if [ -n "$lastFiles" ]; then
	echo -e "$lastFiles"
    else
	return 4
    fi
}
export -f lastFiles
export BATS_TMPDIR

@test "when the second update has no results, another initial call is done" {
    cat > "${BATS_TMPDIR}/lastFiles" <<'EOF'
foo\nbar\nwith space
something else

and\nnow\nmore
final\nset
EOF
    run processAddedFiles --id ID --after -- printf '[%s]-'

    [ $status -eq 0 ]
    [ "$output" = "[foo]-[bar]-[with space]-" ]
    assert_args '--count 2147483647 --'
    assert_last 'with space'

    run processAddedFiles --id ID --after -- printf '[%s]-'

    [ $status -eq 0 ]
    [ "$output" = "[something else]-" ]
    assert_args '--after with\ space --'
    assert_last 'something else'

    run processAddedFiles --id ID --after -- printf '[%s]-'

    [ $status -eq 0 ]
    [ "$output" = "[and]-[now]-[more]-" ]
    assert_args '--count 2147483647 --'
    assert_last 'more'

    run processAddedFiles --id ID --after -- printf '[%s]-'

    [ $status -eq 0 ]
    [ "$output" = "[final]-[set]-" ]
    assert_args '--after more --'
    assert_last 'set'

    run processAddedFiles --id ID --after -- printf '[%s]-'

    [ $status -eq 4 ]
    [ "$output" = "" ]
    assert_args '--count 2147483647 --'
    assert_last 'set'
}


@test "when the second update has no results, another initial call with initial first number is done" {
    cat > "${BATS_TMPDIR}/lastFiles" <<'EOF'
foo\nbar\nwith space
with space\nsomething else

and\nnow\nmore
EOF
    run processAddedFiles --id ID --after --initial-first 2 -- printf '[%s]-'

    [ $status -eq 0 ]
    [ "$output" = "[foo]-[bar]-" ]
    assert_args '--count 2147483647 --'
    assert_last 'bar'

    run processAddedFiles --id ID --after --initial-first 2 -- printf '[%s]-'

    [ $status -eq 0 ]
    [ "$output" = "[with space]-[something else]-" ]
    assert_args '--after bar --'
    assert_last 'something else'

    run processAddedFiles --id ID --after --initial-first 2 -- printf '[%s]-'

    [ $status -eq 0 ]
    [ "$output" = "[and]-[now]-" ]
    assert_args '--count 2147483647 --'
    assert_last 'now'
}

