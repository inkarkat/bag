#!/bin/sh source-this-script

eval "$(runWithPrompt --addAliasSupport bag-consume \
    'ta' \
    'transactional|all|print|bare|no-capture-output|parallel|prepend-on-failure|append-on-failure' \
    'nls' \
    'count|max-lines|stop-on|prefix-command|prefix-command-command|rate-limit|prepend-on|prepend-unless|prepend-before|prepend-after|append-on|append-unless|append-before|append-after'
)"
eval "$(runWithPrompt --addAliasSupport onbag \
    't1S' \
    'transactional|ignore-existing|stop-on-empty|print|bare|no-capture-output|parallel|prepend-on-failure|append-on-failure' \
    'nilst' \
    'count|interval|max-lines|stop-on|stop-after|prefix-command|prefix-command-command|rate-limit|prepend-on|prepend-unless|prepend-before|prepend-after|append-on|append-unless|append-before|append-after'
)"
