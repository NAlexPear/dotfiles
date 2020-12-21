# Node.js conviguration
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Rust configuration
export PATH="/usr/lib/:$PATH:$HOME/.local/bin:$HOME/.cargo/bin"

# fuzzy-searching configuration
export FZF_BASE='/usr/bin/fzf'
export FZF_DEFAULT_COMMAND='fd --type f'

# plugin configuration
export PLUGINS="$HOME/.plugins"

while read -r PLUGIN; do
  source "$PLUGIN";
done < <(fd -g *.zsh $PLUGINS)

# custom prompt
eval "$(starship init zsh)"

# alii
alias ls='exa'

# todo.txt configuration
export TODOTXT_DEFAULT_ACTION='lsa'
alias t='todo.sh -d ~/.config/todo.cfg'

# the One True Editor
export EDITOR=nvim

# Google Cloud SDK configuration
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi

# gcloud configuration
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi
