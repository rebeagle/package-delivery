#!/bin/bash
set -euo pipefail

[[ -n ${APTLY_WORKSPACE} ]]

sed -i "s|/tmp/aptly-workspace|${APTLY_WORKSPACE}|" eng/aptly.conf 
mkdir -p "${APTLY_WORKSPACE}"