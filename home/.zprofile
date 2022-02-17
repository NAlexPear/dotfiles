if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
  export WLR_NO_HARDWARE_CURSORS=1
  exec sway --unsupported-gpu
fi
