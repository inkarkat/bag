#!/bin/bash source-this-script

completeAsCommand bag-consume onbag

_bag_complete()
{
    local IFS=$'\n'
    local cur args opts

    opts='set --prepend add -a --append -B --no-backup -x --transactional list print -p --print -n --lines -q --quiet pop --pop --delete-empty peek --peek delete -d --delete undo -u --undo'
    opts="${opts// /$'\n'}"
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"

    readarray -t args < <(compgen -c bag- 2>/dev/null)
    args=("${args[@]#bag-}")
    args=("${args[@]}" "${args[@]/#/--}")

    readarray -t COMPREPLY < <(compgen -W "${opts}${args[*]:+${opts:+$'\n'}}${args[*]}" -- "$cur")
    [ ${#COMPREPLY[@]} -gt 0 ] && readarray -t COMPREPLY < <(printf "%q\n" "${COMPREPLY[@]}")
    return 0
}
complete -F _bag_complete bag
