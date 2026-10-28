#!/usr/bin/env bash

# write the Rex app settings, which macOS keeps in defaults rather than init.lua

set -o errexit
set -o pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOMAIN="com.superlogical.rex"
THEME="custom-93512DB1-A785-48CF-9572-B62753C18567"

# Rex applies these settings when it starts
if pgrep -f 'Rex Beta.app/Contents/MacOS/Rex$' >/dev/null; then
  echo "quit Rex Beta before running $(basename "$0")" >&2
  exit 1
fi

# replaces every custom theme in Rex with the ones in rex-themes.json
defaults write "$DOMAIN" Workspace.customThemes -data "$(xxd -p "$DIR/themes/rex-themes.json" | tr -d '\n')"
defaults write "$DOMAIN" Workspace.darkThemeID -string "$THEME"

defaults write "$DOMAIN" Workspace.terminalFontName -string "Iosevka"
defaults write "$DOMAIN" Workspace.terminalFontPointSize -float 18
defaults write "$DOMAIN" Workspace.terminalAllowsLigatures -bool true
defaults write "$DOMAIN" Workspace.terminalPaddingColor -string "extendAlways"
defaults write "$DOMAIN" Workspace.allowsTerminalNotifications -bool false
defaults write "$DOMAIN" Workspace.inactivePaneFadeMode -string "both"
defaults write "$DOMAIN" Workspace.tabIconTintMode -string "off"

echo "wrote the Rex settings to $DOMAIN"
