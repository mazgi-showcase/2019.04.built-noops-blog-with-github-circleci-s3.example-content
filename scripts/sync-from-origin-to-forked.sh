#!/bin/bash -eu

readonly GIT_BASE_URI='git@github.com:mazgi-showcase/2019.04.built-noops-blog-with-github-circleci-s3.example-content.git'
REMOTE_EDEN=$(git remote -v | grep "${GIT_BASE_URI} (fetch)" | awk '{ print $1 }')
readonly REMOTE_ORIGIN=$(git remote -v | grep '(fetch)' | grep -vE "^${REMOTE_EDEN:-\:}\s+" | awk '{ print $1 }')
readonly SCRIPT_DIRECTORY=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)

if [[ -z $REMOTE_EDEN ]]; then
  REMOTE_EDEN='eden'
  git remote add $REMOTE_EDEN $GIT_BASE_URI
fi

git fetch $REMOTE_EDEN --prune \
  && git merge --ff-only $REMOTE_EDEN/master \
  && git push $REMOTE_ORIGIN master
