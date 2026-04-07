#!/bin/bash
set -euo pipefail

echo "Smoke test: checking basic tools"
gcc --version
cmake --version
git --version
python3 --version

echo "Base image smoke test passed."
