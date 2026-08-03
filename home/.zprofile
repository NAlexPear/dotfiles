# Homebrew environment (macOS, Apple Silicon prefix)
if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv zsh)"
fi

if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
  export WLR_NO_HARDWARE_CURSORS=1
  exec sway --unsupported-gpu
fi
