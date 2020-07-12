#!/bin/bash
set -euo pipefail

gpg --batch --import << EOF
-----BEGIN PGP PUBLIC KEY BLOCK-----

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
h+I=
=89Nq
-----END PGP PUBLIC KEY BLOCK-----
EOF

gpg --batch --import-ownertrust <<< "FCA303FEDE5B39B883F57340AFCCABC05B517CBB:6:"
