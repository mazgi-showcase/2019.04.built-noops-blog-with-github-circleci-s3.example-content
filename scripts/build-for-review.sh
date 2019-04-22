#!/bin/bash -eu

# --------------------------------
# Build static website for review
readonly PROJECT_ROOT_PATH=$(cd $(dirname ${BASH_SOURCE:-$0})/..; pwd)
readonly GIT_SHORT_SHA1=$(git rev-parse --short HEAD)
readonly PUBLISH_BASE_PATH="${PROJECT_ROOT_PATH}/public"
readonly PUBLISH_PATH="${PUBLISH_BASE_PATH}/${GIT_SHORT_SHA1}"

readonly REVIEW_BASE_URL="https://review.example.com/${GIT_SHORT_SHA1}"

rm -rf "${PUBLISH_BASE_PATH}"

hugo \
  --buildDrafts \
  --buildFuture \
  --baseURL="${REVIEW_BASE_URL}" \
  --destination="${PUBLISH_PATH}"

# --------------------------------
# Write comment to GitHub PR
readonly GITHUB_API_URI='https://api.github.com'
readonly COMMENT="$(printf 'Review URI for current commit: %s\n' "${REVIEW_BASE_URL}/")"

if [[ ! -z "${CIRCLE_PROJECT_USERNAME}" ]] && [[ ! -z "${CIRCLE_PROJECT_REPONAME}" ]] && [[ ! -z "${CIRCLE_PULL_REQUEST}" ]]; then
  pr_number=${CIRCLE_PULL_REQUEST##*/}
  curl \
    -X POST \
    -H 'Content-Type:application/json' \
    -d "{\"body\": \"${COMMENT}\"}" \
    "${GITHUB_API_URI}/repos/${CIRCLE_PROJECT_USERNAME}/${CIRCLE_PROJECT_REPONAME}/issues/${pr_number}/comments?access_token=${GITHUB_PERSONAL_ACCESS_TOKEN}"
fi
