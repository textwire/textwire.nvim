#!/usr/bin/env bash
set -euo pipefail

get_latest_lsp_version() {
    local url="https://codeberg.org/api/v1/repos/textwire/lsp/tags?limit=1"
    local version
    version="$(curl -s "$url" | jq -r '.[0].name')"
    echo "$version"
}

show_spinner() {
    local pid=$!
    local delay=0.1
    local spinstr='|/-\'
    i=0

    while kill -0 $pid 2>/dev/null; do
        i=$(( (i+1) % 4 ))
        printf "\r%s" "${spinstr:$i:1}"
        sleep $delay
    done

    printf "\r"

    wait $!
}
