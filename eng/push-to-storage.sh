#!/bin/bash
set -euo pipefail

[[ -n ${SECRET_STORAGE_ACCOUNT_NAME} && -n ${SECRET_CONTAINER_NAME} && -n ${SECRET_SAS_TOKEN} \
    && -n ${APTLY_WORKSPACE} ]]

SECRET_STORAGE_ACCOUNT_URL="https://${SECRET_STORAGE_ACCOUNT_NAME}.blob.core.windows.net"
CONFIG_FILE_CONTENT=\
"[azure]
type = azureblob
sas_url = ${SECRET_STORAGE_ACCOUNT_URL}/${SECRET_CONTAINER_NAME}?${SECRET_SAS_TOKEN}
"

PUBLISHED_DIR="${APTLY_WORKSPACE}/public"
LOG_FILE="push-log.txt"

rm -f "${LOG_FILE}"
rclone sync "${PUBLISHED_DIR}" "azure:${SECRET_CONTAINER_NAME}" -L --checksum --fast-list \
    --log-level INFO --config <(echo "${CONFIG_FILE_CONTENT}") 2>&1 \
    | sed "s/${SECRET_CONTAINER_NAME}//g" \
    | tee "${LOG_FILE}"
