#!/bin/bash
set -euo pipefail

: "${HUL_REF:?HUL_REF is required (tag, branch, or commit)}"

PREFIX=/tmp/install/hul-common-lib
SRC=/tmp/src/hul-common-lib
DIST=/tmp/dist

rm -rf "${SRC}" "${PREFIX}" "${DIST}"
mkdir -p /tmp/src /tmp/install "${DIST}"

git clone https://github.com/spadi-alliance/hul-common-lib "${SRC}"
cd "${SRC}"

git fetch --tags --force
git checkout "${HUL_REF}"

mkdir -p build
cd build

cmake .. \
  -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
  -DCMAKE_BUILD_TYPE=Release

cmake --build . -j"$(nproc)"
cmake --install .

REF_SAFE="$(echo "${HUL_REF}" | tr '/' '_' )"
TARBALL="hul-common-lib-${REF_SAFE}-alma9.tar.gz"

tar -C /tmp/install -czf "${DIST}/${TARBALL}" hul-common-lib

cat > "${DIST}/manifest.txt" <<EOF
name=hul-common-lib
ref=${HUL_REF}
platform=alma9
compiler=$(gcc --version | head -n 1)
cmake=$(cmake --version | head -n 1)
build_date=$(date -u +%Y-%m-%dT%H:%M:%SZ)
EOF

echo "Created:"
ls -lh "${DIST}/${TARBALL}"
echo "Manifest:"
cat "${DIST}/manifest.txt"
