#!/bin/sh

set -e

BIN=$(cabal list-bin hs-path2ext | head -n 1)

if ! test -x "$BIN"; then
    echo "Error: executable not found or not executable: $BIN"
    exit 1
fi

printf \
    '%s\n' \
    helo.txt \
    /path/to/file.zip \
    /path/to/img.png |
    "$BIN"
