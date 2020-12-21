# oh-my-zsh configuration
export ZSH='~/.config/oh-my-zsh'

plugins=(
  git
  vi-mode
  fzf
  fzf-z
  z
 )

source $ZSH/oh-my-zsh.sh

# fuzzy-searching
export FZF_BASE='/usr/bin/fzf'
export FZF_DEFAULT_COMMAND='fd --type f'

# custom prompt
eval "$(starship init zsh)"

# alii
alias ls='exa'

# todo.txt configuration
export TODOTXT_DEFAULT_ACTION='lsa'
alias t='todo.sh -d ~/.config/todo.cfg'

# the One True Editor
export EDITOR=nvim

# Node.js conviguration
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Rust configuration
export PATH="/usr/lib/:$PATH:$HOME/.local/bin:$HOME/.cargo/bin"

# Google Cloud SDK configuration
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi

# gcloud configuration
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi
