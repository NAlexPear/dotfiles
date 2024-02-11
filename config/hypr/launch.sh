#!/bin/bash

export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --color=pointer:#b04c50,bg+:#1a1d1f
  --reverse
'

# generate message payloads based on args
message=''
case "${1:-commands}" in
  commands) message="$(compgen -c | fzf)" ;; # FIXME: use dex + .desktop files
  emoji) message="wl-copy -n $(uni -c e all | fzf | cut -d ' ' -f1)" ;;
esac

# TODO: include more variations from args
# 1. *.desktop files (or equivalent wrapper scripts)
# 2. frecency weights for commands (based on use in history)

# launch the generated message using dbus/swaymsg
hyprctl dispatch -- exec $message
