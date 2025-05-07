#!/usr/bin/env bash
set -euo pipefail

source ./cmd/scripts/utils.sh

if ! is_jq_installed; then
    echo "❌ Error: jq is required but not installed." >&2
    exit 1
fi

echo "⏰ Checking LSP binary build version..."

LATEST_RELEASE_URL="https://api.github.com/repos/textwire/lsp/releases/latest"

latest_release=$(curl -s "$LATEST_RELEASE_URL")

new_tag=$(echo "$latest_release" | jq -r '.tag_name')
old_tag=$(cat ./bin/.latest-tag)

if [[ "$new_tag" == "$old_tag" ]]; then
    echo "✅ The LSP binaries are up-to-date"
    exit 1
fi

version=("${new_tag#v}")

echo "✅ New LSP version $version found"
echo "⏰ Downloading LSP binaries version $version..."

file_names=(
    "lsp_${version}_darwin_amd64.tar.gz"
    "lsp_${version}_darwin_arm64.tar.gz"
    "lsp_${version}_linux_386.tar.gz"
    "lsp_${version}_linux_amd64.tar.gz"
    "lsp_${version}_windows_386.tar.gz"
    "lsp_${version}_windows_amd64.tar.gz"
    "lsp_${version}_windows_amr64.tar.gz"
)

for file_name in "${file_names[@]}"; do
    url="https://github.com/textwire/lsp/releases/download/$new_tag/$file_name"
    dest="bin/$file_name"

    new_name="textwire_${file_name/${version}_/}"
    new_name="${new_name/.tar.gz/}"

    if [[ "$new_name" == *"windows"* ]]; then
        new_name="${new_name}.exe"
    fi

    # Check if the file exists
    http_code=$(curl -s -L -o /dev/null -w "%{http_code}" "$url")

    if [[ "$http_code" -ne 200 ]]; then
        echo "⚠️ File $url doesn't exists. Skipping..."
        continue
    fi

    # Download a file with curl
    curl -o "$dest" "$url" > /dev/null 2>&1

    # Make the file executable
    chmod +x "$dest"

    echo "✅ Downloaded $file_name"
done

# Update the latest tag
echo "$new_tag" > bin/.latest-tag

echo "✅ All LSP binaries are downloaded and updated"
