#!/usr/bin/env bash
# Official archived Linux x86-64 compiler + matching core, with fixed digests.
set -euo pipefail
root="${1:?usage: install-moon.sh EMPTY_TOOLCHAIN_DIRECTORY}"
if [[ -e "$root" ]]; then echo 'Toolchain target already exists; refusing to overwrite.' >&2; exit 1; fi
mkdir -p "$root"
work="$(mktemp -d)"
trap 'rm -rf -- "$work"' EXIT
curl --fail --location --retry 2 --connect-timeout 15 --max-time 240 'https://cli.moonbitlang.com/binaries/0.10.16%2Bb1a0e846e/moonbit-linux-x86_64.tar.gz' -o "$work/moon.tar.gz"
curl --fail --location --retry 2 --connect-timeout 15 --max-time 120 'https://cli.moonbitlang.com/cores/core-0.10.16%2Bb1a0e846e.tar.gz' -o "$work/core.tar.gz"
printf '%s  %s\n' '84ae424cd31bc485d2cf4d3736534e52f2f265ceafb562a187b9ab26d9566212' "$work/moon.tar.gz" 'e7db6e3c80a97af953598b374cf14f3e330918b1ca4659b141b9f550c9c0adb0' "$work/core.tar.gz" | sha256sum --check
tar -xzf "$work/moon.tar.gz" -C "$root"
mkdir -p "$root/lib"
tar -xzf "$work/core.tar.gz" -C "$root/lib"
MOON_HOME="$root" MOON_TOOLCHAIN_ROOT="$root" "$root/bin/moon" version --all
