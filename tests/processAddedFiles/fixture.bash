#!/bin/bash

export XDG_CONFIG_HOME="${BATS_TMPDIR}"
setup() {
    rm -f -- "${BATS_TMPDIR}/processAddedFiles"
}

export LASTFILES
lastFiles()
{
    { printf '%q ' "$@"; printf \\n; } > "$ARG_FILESPEC"

    if [ "$LASTFILES" ]; then
	echo -e "$LASTFILES"
    fi
}
export -f lastFiles

export ARG_FILESPEC="${BATS_TMPDIR}/args"
assert_args() {
    [ "$(cat "$ARG_FILESPEC")" = "${1?} " ]
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
