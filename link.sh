#!/usr/bin/env bash

set -o errexit
set -o pipefail

# include dotfiles in globs, and expand to nothing (not the literal pattern)
# when a directory is empty -- everything in home/ is a dotfile
shopt -s dotglob nullglob

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG="$HOME/.config"
CONFIG_SOURCE="$REPO/config"
HOME_SOURCE="$REPO/home"
CLAUDE="$HOME/.claude"

# symlink each top-level entry of $1 into the directory $2, skipping the
# basenames given as any further arguments
link_all() {
  local source_dir="$1" target_dir="$2" item name
  shift 2
  for item in "$source_dir"/*; do
    name="$(basename "$item")"
    if [[ " $* " == *" $name "* ]]; then
      continue
    fi
    echo "linking $item -> $target_dir/$name"
    ln -Fs "$item" "$target_dir/$name"
  done
}

# create the .config directory if it doesn't exist
mkdir -p "$CONFIG"

# symlink top-level .config subdirectories and files
link_all "$CONFIG_SOURCE" "$CONFIG"

# symlink top-level $HOME subdirectories and files
link_all "$HOME_SOURCE" "$HOME" .claude

# claude keeps session state next to its config, so link the files one by one
mkdir -p "$CLAUDE"
link_all "$HOME_SOURCE/.claude" "$CLAUDE"
