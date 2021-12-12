#!/bin/sh source-this-script

addAliasSupport bag-consume \
    'ta' \
    'transactional|worst-status|all|print|bare|no-capture-output|trailing-prompt|no-trailing-prompt|no-output-no-prompt|no-output-no-error|emulate-prompt|parallel|exit-on-success|exit-on-failure|prepend-on-failure|append-on-failure' \
    'nls' \
    'count|max-lines|stop-on|initial-status|prefix-command|prefix-command-command|rate-limit|exit-on|prepend-on|prepend-unless|prepend-before|prepend-after|append-on|append-unless|append-before|append-after'
addAliasSupport onbag \
    't1S' \
    'transactional|ignore-existing|stop-on-empty|print|bare|no-capture-output|trailing-prompt|no-trailing-prompt|no-output-no-prompt||no-output-no-error|emulate-prompt|parallel|exit-on-success|exit-on-failure|prepend-on-failure|append-on-failure' \
    'nilst' \
    'count|interval|max-lines|stop-on|stop-after|initial-status|prefix-command|prefix-command-command|rate-limit|exit-on|prepend-on|prepend-unless|prepend-before|prepend-after|append-on|append-unless|append-before|append-after'
