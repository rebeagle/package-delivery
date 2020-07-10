#!/bin/bash
set -euo pipefail

[[ -n ${SECRET_GPG_SIGNING_KEY_CONTENT} && -n ${SECRET_GPG_SIGNING_KEY_PASSWORD} \
    && ${GPG_SIGNING_KEY_FINGERPRINT} ]]

mkdir -p $HOME/.gnupg
chmod 700 $HOME/.gnupg
echo "allow-preset-passphrase" >> $HOME/.gnupg/gpg-agent.conf
gpg --batch --import <<< "${SECRET_GPG_SIGNING_KEY_CONTENT}"
PUBLIC_FINGERPRINT=$(gpg --list-keys --with-colons | awk -F: '($1 == "fpr"){ print $10 }' | head -n 1)
gpg --batch --import-ownertrust <<< "${PUBLIC_FINGERPRINT}:6:"
SUB_KEYGRIP=$(gpg --list-secret-keys --with-colons \
    | awk -F: -v "signingkey=${GPG_SIGNING_KEY_FINGERPRINT}" \
    '($1 ~ "grp") && (fpr == signingkey){ print $10 } ($1 == "fpr"){ fpr=$10 }')

if [[ -z $SUB_KEYGRIP ]]; then
    echo "Could not locate keygrip for fingerprint: ${GPG_SIGNING_KEY_FINGERPRINT}."
    exit 1
fi

/usr/lib/gnupg2/gpg-preset-passphrase -c "${SUB_KEYGRIP}" <<< "${SECRET_GPG_SIGNING_KEY_PASSWORD}"