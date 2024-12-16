# Bag

_Commands for collecting lines / shell commands in a special file and then / concurrently consuming them._

![Build Status](https://github.com/inkarkat/bag/actions/workflows/build.yml/badge.svg)

### Dependencies

* Bash, GNU `sed`
* [inkarkat/shell-basics](https://github.com/inkarkat/shell-basics)
* [inkarkat/shell-filesystem](https://github.com/inkarkat/shell-filesystem)
* [inkarkat/shell-tools](https://github.com/inkarkat/shell-tools)
* automated testing is done with _bats - Bash Automated Testing System_ (https://github.com/bats-core/bats-core)

### Installation

* The `./bin` subdirectory is supposed to be added to `PATH`.
* The [shell/aliases.sh](shell/aliases.sh) script (meant to be sourced in `.bashrc`) defines Bash aliases around the provided commands.
* The [shell/bash/completions.sh](shell/bash/completions.sh) script (meant to be sourced in `.bashrc`) defines Bash completions for the provided commands.
