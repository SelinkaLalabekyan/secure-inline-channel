#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
printf '\n== Source tests ==\n'
make test
printf '\n== Daemon syntax check ==\n'
make syntax-daemon
printf '\n== Configuration warning ==\n'
if grep -q '^psk_hex=000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f$' configs/device*.conf; then
  echo 'WARNING: Public demonstration PSK detected. Replace for a real demonstration.'
fi
printf '\n== Optional integration ==\n'
echo 'Run on a supported Linux VM: sudo ./tests/test_integration.sh'
