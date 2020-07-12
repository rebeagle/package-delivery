#!/bin/bash
set -euo pipefail

APTLY_FILE="aptly_${APTLY_VERSION}_amd64.deb"
curl -LO "https://github.com/aptly-dev/aptly/releases/download/v${APTLY_VERSION}/${APTLY_FILE}"
sha256sum -c <<< "${APTLY_SHA256}  ${APTLY_FILE}"

curl -LO "https://raw.githubusercontent.com/rebeagle/ok.sh/master/ok.sh"
chmod +x "ok.sh"

sudo apt-get install "./${APTLY_FILE}" rclone symlinks jq