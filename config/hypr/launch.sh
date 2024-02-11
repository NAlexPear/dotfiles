#!/bin/bash

export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --color=pointer:#b04c50,bg+:#1a1d1f
  --reverse
'

# generate message payloads based on args
applications=~/.local/share/applications
message=''
case "${1:-commands}" in
  # FIXME: use the Name field instead of the desktop file name itself
  commands) message="dex $applications/$(ls $applications | rg -e desktop | fzf)" ;;
  emoji) message="wl-copy -n $(uni -c e all | fzf | cut -d ' ' -f1)" ;;
esac

# launch the generated message using dbus/swaymsg
hyprctl dispatch -- exec $message
