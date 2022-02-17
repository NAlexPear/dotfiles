# handle $PATH mods
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
. "$HOME/.cargo/env"

# handle Wayland settings
export QT_QPA_PLATFORM=wayland
export GTK_BACKEND=wayland
export MOZ_ENABLE_WAYLAND=1
