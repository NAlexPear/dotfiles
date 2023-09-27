#!/usr/bin/env bash

set -o errexit
set -o pipefail

CONFIG="$HOME/.config"
CONFIG_SOURCE="$(dirname $0)/config"
HOME_SOURCE="$(dirname $0)/home"

# create the .config directory if it doesn't exist
mkdir -p "$CONFIG"

# symlink top-level .config subdirectories and files
while read -r ITEM; do
  ln -Fs "$(greadlink -m $CONFIG_SOURCE/$ITEM)" "$CONFIG/$ITEM"
done < <(ls $CONFIG_SOURCE)

# symlink top-level $HOME subdirectories and files
while read -r ITEM; do
  ln -Fs "$(greadlink -m $HOME_SOURCE/$ITEM)" "$HOME/$ITEM"
done < <(ls $HOME_SOURCE)
