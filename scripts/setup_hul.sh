#!/bin/bash
set -euo pipefail

PREFIX="${1:-/work/hul-common-lib}"
TARBALL="${2:?Please specify tarball path}"

BASE_DIR="$(dirname "${PREFIX}")"
mkdir -p "${BASE_DIR}"

tar -xzf "${TARBALL}" -C "${BASE_DIR}"

cat > "${PREFIX}/setup.sh" <<EOF
export HUL_ROOT=${PREFIX}
export PATH=${PREFIX}/bin:\$PATH
export LD_LIBRARY_PATH=${PREFIX}/lib64:${PREFIX}/lib:\${LD_LIBRARY_PATH:-}
EOF

echo "Installed to ${PREFIX}"
echo "Run:"
echo "  source ${PREFIX}/setup.sh"
