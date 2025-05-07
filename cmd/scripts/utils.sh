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
