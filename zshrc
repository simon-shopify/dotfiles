export PATH="$HOME/bin:/usr/local/bin:$GOPATH/bin:$PATH"

export ZSH=$HOME/.oh-my-zsh

ZSH_CUSTOM=$HOME/.oh-my-zsh-custom
ZSH_THEME="bira"
CASE_SENSITIVE="true"
DISABLE_AUTO_TITLE="true"
COMPLETION_WAITING_DOTS="true"

plugins=(git vagrant lein)

source $ZSH/oh-my-zsh.sh

alias g="grep -rnI"

export EDITOR=vim
export TZ=America/Montreal
[[ -s $HOME/.zshrc.local ]] && source "$HOME/.zshrc.local"
