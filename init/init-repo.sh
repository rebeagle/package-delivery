#!/bin/bash
set -euo pipefail

[[ -n ${APTLY_REPO_NAME} && -n ${APTLY_DISTRIBUTION} && -n ${APTLY_PREFIX} \
    && -n ${GPG_SIGNING_KEY_FINGERPRINT} ]]

aptly -config="eng/aptly.conf" repo create "${APTLY_REPO_NAME}"
aptly -config="eng/aptly.conf" publish repo -acquire-by-hash -distribution="${APTLY_DISTRIBUTION}" \
    -gpg-key="${GPG_SIGNING_KEY_FINGERPRINT}" "${APTLY_REPO_NAME}" "${APTLY_PREFIX}"