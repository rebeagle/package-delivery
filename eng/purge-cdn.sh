#!/bin/bash
set -euo pipefail

[[ -n ${SECRET_RESOURCE_GROUP_NAME} && -n ${CDN_ENDPOINT_NAME} && -n ${CDN_PROFILE_NAME} &&
 -n "${APTLY_PREFIX}" ]]

az cdn endpoint purge -g "${SECRET_RESOURCE_GROUP_NAME}" -n "${CDN_ENDPOINT_NAME}" \
    --profile-name "${CDN_PROFILE_NAME}" --content-paths "/paranoidnas/${APTLY_PREFIX}/dists/*"
