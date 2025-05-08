#!/usr/bin/env bash
set -euo pipefail

get_json_field_value() {
    local json="$1"
    local key="$2"

    if [[ "$json" =~ \"$key\"[[:space:]]*\:[[:space:]]*\"([^\"]*)\" ]]; then
        echo "${BASH_REMATCH[1]}"
    else
        echo "" >&2
        return 1
    fi
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
