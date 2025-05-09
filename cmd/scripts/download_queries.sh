#!/usr/bin/env bash
set -euo pipefail

file_names=("highlights.scm" "injections.scm")

echo "⏰ Downloading latest CSM query files..."

for file_name in "${file_names[@]}"; do
    url="https://raw.githubusercontent.com/textwire/tree-sitter-textwire/refs/heads/master/queries/$file_name"
    dest="queries/$file_name"

    # Get the content of the file
    file_content=$(curl -s "$url")

    if [[ "$file_content" == *"404 Not Found"* ]]; then
        echo "❌ $url not found"
        exit 1
    fi

    # Update/create the destination file
    if [[ -n "$file_content" ]]; then
        echo "$file_content" > "$dest"
        echo "✅ Updated $dest"
    else
        echo "❌ Failed to download $url"
        exit 1
    fi
done

echo "✅ All CSM query files are downloaded and updated"
