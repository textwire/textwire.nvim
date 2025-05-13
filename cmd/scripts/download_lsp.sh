#!/usr/bin/env bash
set -euo pipefail

source ./cmd/scripts/utils.sh

echo "⏰ Checking LSP binary build version..."

DIVIDER="-----------------------------------------------------------------"
LATEST_RELEASE_URL="https://api.github.com/repos/textwire/lsp/releases/latest"

latest_release=$(curl -s "$LATEST_RELEASE_URL")

new_tag=$(get_json_field_value "$latest_release" "tag_name")
old_tag=$(cat ./bin/.latest-tag)

if [[ "$new_tag" == "$old_tag" ]]; then
    echo "✅ The LSP binaries are up-to-date"
    exit 0
fi

version=("${new_tag#v}")

echo "✅ New LSP version $version found"

file_names=(
    "lsp_${version}_darwin_amd64.tar.gz"
    "lsp_${version}_darwin_arm64.tar.gz"
    "lsp_${version}_linux_386.tar.gz"
    "lsp_${version}_linux_amd64.tar.gz"
    "lsp_${version}_windows_386.tar.gz"
    "lsp_${version}_windows_amd64.tar.gz"
    "lsp_${version}_windows_arm64.tar.gz"
)

remove_unused_files() {
    rm "$1" > /dev/null 2>&1
    rm bin/README.md > /dev/null 2>&1
    rm bin/LICENSE > /dev/null 2>&1
    rm bin/CHANGELOG.md > /dev/null 2>&1
}

for file_name in "${file_names[@]}"; do
    echo "$DIVIDER"

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

    echo "⏰ Downloading $file_name..."

    # Download a file with curl
    curl -L -o "$dest" "$url" > /dev/null 2>&1 &
    show_spinner

    echo "⏰ Unpacking $file_name..."

    tar -xzf "$dest" -C bin

    echo "⏰ Deleting unnecessary files.."

    remove_unused_files "$dest"

    bin_name="textwire_${file_name/${version}_/}"
    bin_name="${bin_name/.tar.gz/}"
    old_bin_dest="bin/lsp"

    # Add .exe to the Windows binaries
    if [[ "$bin_name" == *"windows"* ]]; then
        bin_name="${bin_name}.exe"
        old_bin_dest="bin/lsp.exe"
    fi

    bin_dest="bin/$bin_name"

    # Rename binary file
    mv "$old_bin_dest" "$bin_dest"

    # Make the file executable
    chmod +x "$bin_dest"

    echo "✅ LSP $bin_name installed to the bin directory"
done

# Update the latest tag
echo "$new_tag" > bin/.latest-tag

echo "$DIVIDER"
echo "✅ All LSP binaries are downloaded and updated"
