#!/bin/bash
set -euo pipefail

[[ -n ${APTLY_DISTRIBUTION} && -n ${APTLY_PREFIX} && -n ${GPG_SIGNING_KEY_FINGERPRINT} ]]

aptly -config="eng/aptly.conf"  publish update -gpg-key="${GPG_SIGNING_KEY_FINGERPRINT}" \
    "${APTLY_DISTRIBUTION}" "${APTLY_PREFIX}"