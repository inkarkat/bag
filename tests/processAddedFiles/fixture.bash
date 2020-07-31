#!/bin/bash

export XDG_CONFIG_HOME="${BATS_TMPDIR}"

export LASTFILES LASTFILES_EXIT NEWERFILES
lastFiles()
{
    { printf '%q ' "$@"; printf \\n; } > "$ARG_FILESPEC"

    [ "$LASTFILES_EXIT" ] && return $LASTFILES_EXIT

    if [ "$LASTFILES" ]; then
	echo -e "$LASTFILES"
    fi
}
export -f lastFiles
newerFiles()
{
    { printf '> '; printf '%q ' "$@"; printf \\n; } > "$ARG_FILESPEC"

    [ "$NEWERFILES_EXIT" ] && return $NEWERFILES_EXIT

    if [ "$NEWERFILES" ]; then
	echo -e "$NEWERFILES" | awk -v start=1000 '{ print ++start "\t" $0 }'
    fi
}
export -f newerFiles

export ARG_FILESPEC="${BATS_TMPDIR}/args"
assert_args() {
    if [ -n "${1?}" ]; then
	[ "$(cat "$ARG_FILESPEC")" = "${1?} " ]
    else
	[ ! -e "$ARG_FILESPEC" ]
    fi
}
dump_args() {
    prefix '#' "$ARG_FILESPEC" >&3
}

assert_last() {
    [ "$(miniDB --table processAddedFiles --schema 'ID LAST' --query ID --columns LAST)" = "${1?}" ]
}
dump_last() {
    miniDB --table processAddedFiles --schema 'ID LAST' --query ID --columns LAST | prefix '#' >&3
}

setup() {
    rm -f -- "${BATS_TMPDIR}/processAddedFiles" "$ARG_FILESPEC"
}
