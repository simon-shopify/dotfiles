#!/bin/zsh

export PATH="$HOME/.config/bin/$(uname -s)-$(uname -m):$HOME/.config/bin/any:/usr/local/bin:$GOPATH/bin:$PATH"
export PATH="$HOME/.cabal/bin:$PATH"

export ZSH=$HOME/.oh-my-zsh

ZSH_CUSTOM=$HOME/.oh-my-zsh-custom
ZSH_THEME="sgnr"
CASE_SENSITIVE="true"
DISABLE_AUTO_TITLE="true"
COMPLETION_WAITING_DOTS="true"

plugins=(git vagrant lein bundler golang)

source $ZSH/oh-my-zsh.sh

alias g="grep -rnI --exclude='*.a'"

export TERM=xterm
export LANG="en_US.UTF-8"
export EDITOR=emacs
export TZ=America/Montreal
[[ -s $HOME/.zshrc.local ]] && source "$HOME/.zshrc.local"

export GOBIN="$GOPATH/bin"
export IM_ALREADY_PRO_THANKS=1

NEW_SSH_AUTH_SOCK="$HOME/.ssh/auth-sock/auth-sock"
if test $SSH_AUTH_SOCK && [ $SSH_AUTH_SOCK != $NEW_SSH_AUTH_SOCK ]; then
  mkdir -p "$(dirname "$NEW_SSH_AUTH_SOCK")"
  rm -f $NEW_SSH_AUTH_SOCK
  ln -sf $SSH_AUTH_SOCK $NEW_SSH_AUTH_SOCK
fi
export SSH_AUTH_SOCK=$NEW_SSH_AUTH_SOCK
