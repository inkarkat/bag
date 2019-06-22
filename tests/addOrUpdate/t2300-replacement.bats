#!/usr/bin/env bats

load temp

@test "update with nonmatching pattern appends LINE not REPLACEMENT at the end" {
    init
    UPDATE="foo=new"
    run addOrUpdate --line "$UPDATE" --update-match "foosball=never" --replacement "not=used" "$FILE"
    [ $status -eq 0 ]
    [ "$output" = "$(cat "$INPUT")
$UPDATE" ]
}

@test "update with pattern matching full line uses REPLACEMENT" {
    init
    run addOrUpdate --line "foo=new" --update-match '^foo=h.*$' --replacement "ox=replaced" "$FILE"

    [ $status -eq 0 ]
    [ "$output" = 'sing/e=wha\ever
foo=bar
ox=replaced
# SECTION
foo=hi' ]
}

@test "update with pattern matching partial line uses REPLACEMENT just for match" {
    init
    run addOrUpdate --line "foo=new" --update-match 'oo=h[a-z]\+' --replacement "ox=replaced" "$FILE"
    [ $status -eq 0 ]
    [ "$output" = 'sing/e=wha\ever
foo=bar
fox=replaced bar baz
# SECTION
foo=hi' ]
}

@test "REPLACEMENT can refer to capture groups" {
    init
    run addOrUpdate --line "foo=new" --update-match '\([a-z]\+\)=\(ho\+\) .* \([a-z]\+\)$' --replacement "\2=\1 \3 (&)" "$FILE"
    [ $status -eq 0 ]
    [ "$output" = 'sing/e=wha\ever
foo=bar
hoo=foo baz (foo=hoo bar baz)
# SECTION
foo=hi' ]
}

@test "REPLACEMENT with forward and backslashes" {
    init
    run addOrUpdate --line "foo=new" --update-match '^foo=h.*$' --replacement '/new\\=\\\\here//' "$FILE"
    [ $status -eq 0 ]
    [ "$output" = 'sing/e=wha\ever
foo=bar
/new\=\\here//
# SECTION
foo=hi' ]
}

@test "empty REPLACEMENT" {
    init
    run addOrUpdate --line "foo=new" --update-match '^foo=h.*$' --replacement "" "$FILE"

    [ $status -eq 0 ]
    [ "$output" = 'sing/e=wha\ever
foo=bar

# SECTION
foo=hi' ]
}

