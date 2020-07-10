#!/bin/bash
set -euo pipefail

[[ -n ${APTLY_WORKSPACE} && -n ${SECRET_STORAGE_ACCOUNT_NAME} ]]

APTLY_ARCHIVE="aptly.tar.xz"

tar -cvJf "${APTLY_ARCHIVE}" -C "${APTLY_WORKSPACE}" "."

az storage blob upload --account-name "${SECRET_STORAGE_ACCOUNT_NAME}" --auth-mode login \
     -c "eng" -f "${APTLY_ARCHIVE}" -n "${APTLY_ARCHIVE}"
