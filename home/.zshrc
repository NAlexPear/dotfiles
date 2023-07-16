# configure more robust history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
setopt extended_history       
setopt hist_expire_dups_first 
setopt hist_ignore_dups      
setopt hist_ignore_space    

# configure directory-changing behavior
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus

# configure completion
zstyle ':completion:*'  matcher-list 'm:{a-z}={A-Z}'
unsetopt menu_complete   
unsetopt flowcontrol
unsetopt nomatch
setopt auto_menu         
setopt complete_in_word
setopt always_to_end

# configure vi mode
bindkey -v

# Language and locale configuration
export LANG=en_US.UTF-8
export LC_CTYPE="en_US.UTF-8"
export LC_NUMERIC="en_US.UTF-8"
export LC_TIME="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"
export LC_MONETARY="en_US.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
export LC_PAPER="en_US.UTF-8"
export LC_NAME="en_US.UTF-8"
export LC_ADDRESS="en_US.UTF-8"
export LC_TELEPHONE="en_US.UTF-8"
export LC_MEASUREMENT="en_US.UTF-8"
export LC_IDENTIFICATION="en_US.UTF-8"

# Node.js version configuration
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# fuzzy-searching configuration
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /opt/homebrew/opt/fzf/shell/key-bindings.zsh ] && source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
export FZF_BASE='/usr/bin/fzf'
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --color=pointer:#b04c50,bg+:#111314
'
eval "$(zoxide init zsh)"
export _ZO_FZF_OPTS=$FZF_DEFAULT_OPTS"
  --preview='exa -T --icons --git-ignore {2} | head -n 50'
"
zle -N __zoxide_zi
function _z_search() {
  zle __zoxide_zi
  zle reset-prompt
}
zle -N _z_search
bindkey '^G' _z_search

# custom prompt
eval "$(starship init zsh)"

# alii
alias g='git'
alias ga='git add'
alias gaa='git add --all'
alias gb='git branch'
alias gbD='git branch -D'
alias gbs='git bisect'
alias gcb='git checkout -b'
alias gco='git checkout'
alias gc='git commit'
alias gca='git commit --amend'
alias gcmsg='git commit -m'
alias gd='git diff'
alias gf='git fetch'
alias glo='git log --oneline --decorate'
alias glol="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'"
alias glols="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --stat"
alias gp='git push'
alias gr='git remote'
alias gra='git remote add'
alias grb='git rebase'
alias gst='git status'
alias ls='exa'
alias l='erd -c ls'
alias tree='erd -c tree'

# todo.txt configuration
export TODOTXT_DEFAULT_ACTION='lsa'
alias t='todo.sh -d ~/.config/todo.cfg'

# the One True Editor
export EDITOR=nvim

# Google Cloud SDK configuration
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi

# gcloud configuration
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi
