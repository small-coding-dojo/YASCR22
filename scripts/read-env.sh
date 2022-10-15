#!/bin/sh
#
# Export all variables defined in scripts/.env to the current shell.
#
ENV_PATH=${0%/*}/.env

read_env() {
    set -a
    # shellcheck source=.env
    . "${ENV_PATH}"
    set +a
}
