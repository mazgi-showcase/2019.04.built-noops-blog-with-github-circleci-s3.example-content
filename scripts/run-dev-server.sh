#!/bin/bash -eu

readonly SCRIPT_DIRECTORY=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)
readonly _HUGO_PORT=${HUGO_PORT:-31313}

cd "${SCRIPT_DIRECTORY}/.."
bin/hugo server --buildDrafts --port $_HUGO_PORT
