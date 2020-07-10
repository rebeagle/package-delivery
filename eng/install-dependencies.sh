#!/bin/bash
set -euo pipefail

sudo apt install rclone

APTLY_FILE="aptly_${APTLY_VERSION}_amd64.deb"
curl -LO "https://github.com/aptly-dev/aptly/releases/download/v${APTLY_VERSION}/${APTLY_FILE}"
sha256sum -c <<< "${APTLY_SHA256}  ${APTLY_FILE}"
sudo apt install "./${APTLY_FILE}"