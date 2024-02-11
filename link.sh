#!/usr/bin/env bash

set -o errexit
set -o pipefail

CONFIG="$HOME/.config"
APPS="$HOME/.local/share/applications"
APP_SOURCE="$(dirname $0)/local/share/applications"
CONFIG_SOURCE="$(dirname $0)/config"
HOME_SOURCE="$(dirname $0)/home"

# create the .config directory if it doesn't exist
mkdir -p "$CONFIG"

# create the applications directory if it doesn't exist
mkdir -p "$APPS"

# symlink top-level .config subdirectories and files
while read -r ITEM; do
  ln -nsf "$(readlink -m $CONFIG_SOURCE/$ITEM)" "$CONFIG/$ITEM"
done < <(ls $CONFIG_SOURCE)

# symlink top-level $HOME subdirectories and files
while read -r ITEM; do
  ln -nsf "$(readlink -m $HOME_SOURCE/$ITEM)" "$HOME/$ITEM"
done < <(ls $HOME_SOURCE)

# symlink .desktop files into the local applications directory
while read -r ITEM; do
  ln -nsf "$(readlink -m $APP_SOURCE/$ITEM)" "$APPS/$ITEM"
done < <(ls $APP_SOURCE | rg -e desktop)
