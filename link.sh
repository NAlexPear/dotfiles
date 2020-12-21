#!/usr/bin/env bash

set -o errexit
set -o pipefail

CONFIG="$HOME/.config"
PLUGINS="$HOME/.plugins"
CONFIG_SOURCE="$(dirname $0)/config"
HOME_SOURCE="$(dirname $0)/home"
PLUGINS_SOURCE="$(dirname $0)/plugins"

# create the .config directory if it doesn't exist
mkdir -p "$CONFIG"

# symlink top-level .config subdirectories and files
while read -r ITEM; do
  ln -nsf "$(readlink -m $CONFIG_SOURCE/$ITEM)" "$CONFIG/$ITEM"
done < <(ls $CONFIG_SOURCE)

# symlink top-level $HOME subdirectories and files
while read -r ITEM; do
  ln -nsf "$(readlink -m $HOME_SOURCE/$ITEM)" "$HOME/$ITEM"
done < <(ls $HOME_SOURCE)

# symlink the plugins directory directly
ln -nsf "$(readlink -m $PLUGINS_SOURCE)" "$PLUGINS"
