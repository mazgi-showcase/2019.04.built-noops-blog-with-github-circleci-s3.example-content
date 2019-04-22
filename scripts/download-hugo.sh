#!/bin/bash -eu

readonly HUGO_VERSION="0.52"
readonly HUGO_DOWN_LOAD_URI="https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_macOS-64bit.tar.gz"
readonly SCRIPT_DIRECTORY=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)

cd "${SCRIPT_DIRECTORY}/.."
#if [[ ! -f bin/hugo ]; then
  curl -Lo /tmp/hugo.tar.gz "$HUGO_DOWN_LOAD_URI"
  tar xf /tmp/hugo.tar.gz -C bin/
#fi
