#!/bin/bash

xrandr --output DP-0 --left-of DP-2 --mode 1920x1080 --rate 144.00 --rotate left
xrandr --output DP-2 --mode 1920x1080 --rate 144.00 --pos 1080x408

xmodmap ~/.Xmodmap

hsetroot -solid '#000000'
picom -CGb

dbus-update-activation-environment --systemd DISPLAY
eval "$(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)"
export SSH_AUTH_SOCK

exec i3
