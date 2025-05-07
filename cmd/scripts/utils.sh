#!/usr/bin/env bash
set -euo pipefail

is_jq_installed() {
    if command -v jq >/dev/null 2>&1; then
        return 0 # success
    fi

    return 1 # failure
}
