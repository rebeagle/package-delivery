#!/bin/bash
set -euo pipefail

[[ -n ${APTLY_REPO_NAME}} ]]

aptly -config="eng/aptly.conf" repo include -repo="${APTLY_REPO_NAME}" -uploaders-file="eng/uploaders.json" incoming