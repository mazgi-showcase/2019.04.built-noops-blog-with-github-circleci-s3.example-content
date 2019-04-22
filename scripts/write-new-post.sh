#!/bin/bash -eu

readonly title=$1
readonly path="posts/$(date +%Y.%m)/${title}"
readonly SCRIPT_DIRECTORY=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)

cd "${SCRIPT_DIRECTORY}/.."
mkdir -p static/$path
cp themes/dummy-theme/static/common/og.png static/$path/
for lang in ja en
do
  bin/hugo new ${path}.${lang}.md
done
git checkout -b $path
