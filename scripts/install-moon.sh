#!/usr/bin/env bash
# Official archived Linux x86-64 compiler + matching core, with fixed digests.
set -euo pipefail
root="${1:?usage: install-moon.sh EMPTY_TOOLCHAIN_DIRECTORY}"
if [[ -e "$root" ]]; then echo 'Toolchain target already exists; refusing to overwrite.' >&2; exit 1; fi
mkdir -p "$root"
work="$(mktemp -d)"
trap 'rm -rf -- "$work"' EXIT
curl --fail --location --retry 2 --connect-timeout 15 --max-time 240 'https://cli.moonbitlang.com/binaries/0.10.22%2B124d61d05/moonbit-linux-x86_64.tar.gz' -o "$work/moon.tar.gz"
curl --fail --location --retry 2 --connect-timeout 15 --max-time 120 'https://cli.moonbitlang.com/cores/core-0.10.22%2B124d61d05.tar.gz' -o "$work/core.tar.gz"
printf '%s  %s\n' 'aeb78ded1d5e25185ed788328cacef5e843a9ab923145523b7652e8d082f74fb' "$work/moon.tar.gz" 'a22977f3d346e4a189fe521b2d265b2fbb6c00e3ff80342246fb6f8f26c9f156' "$work/core.tar.gz" | sha256sum --check
tar -xzf "$work/moon.tar.gz" -C "$root"
# Archived executables may lack their execute bit; normalize only known tools.
for tool in moon moonc moonrun mooncake moonfmt mooninfo moon-wasm-opt moon-cove-report moon_cove_report moonc-prove moon-cram moondoc moon-lsp moon-ide internal/tcc; do
  if [[ -f "$root/bin/$tool" ]]; then chmod u+x "$root/bin/$tool"; fi
done
mkdir -p "$root/lib"
tar -xzf "$work/core.tar.gz" -C "$root/lib"
root="$(cd "$root" && pwd)"
export MOON_HOME="$root" MOON_TOOLCHAIN_ROOT="$root"
export PATH="$root/bin:$PATH"
moon version --all
(cd "$root/lib/core" && moon bundle --all)
