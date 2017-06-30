export PROMPT="%F{magenta}%n%F{default} on %F{yellow}$(uname | awk '{ print tolower($0) }')%F{default} %F{magenta}%~%F{default}
%(?..%F{red}%?%F{default} )$ "
export TERM=xterm
export LANG="en_US.UTF-8"
export EDITOR=emacs
export TZ=America/Montreal
[[ -s $HOME/.zshrc.local ]] && source "$HOME/.zshrc.local"

setopt interactivecomments

HISTFILE=$HOME/.zsh_history
setopt APPEND_HISTORY
HISTSIZE=1200
SAVEHIST=1000
setopt HIST_EXPIRE_DUPS_FIRST
setopt EXTENDED_HISTORY
autoload -Uz compinit && compinit

export IM_ALREADY_PRO_THANKS=1
export SKIP_BOOTSTRAP=1
export TDD=0
export BACKTRACE=1

if [[ "$(uname -s)" = 'Linux' ]]; then
  NEW_SSH_AUTH_SOCK="$HOME/.ssh/auth-sock/auth-sock"
  if test $SSH_AUTH_SOCK && [ $SSH_AUTH_SOCK != $NEW_SSH_AUTH_SOCK ]; then
    mkdir -p "$(dirname "$NEW_SSH_AUTH_SOCK")"
    rm -f $NEW_SSH_AUTH_SOCK
    ln -sf $SSH_AUTH_SOCK $NEW_SSH_AUTH_SOCK
  fi
  export SSH_AUTH_SOCK=$NEW_SSH_AUTH_SOCK
fi

function disas () {
  gdb --batch -ex "file $1" -ex "disas $2"
}

function ias () {
  TMP=$(mktemp)
  SOURCE="main: $1"
  echo "$SOURCE" | as -o "$TMP" && gdb --batch -ex "file $TMP" -ex "disas /r main"
}

[ -f /opt/dev/dev.sh ] && source /opt/dev/dev.sh
[ -f $HOME/.cargo/env ] && source $HOME/.cargo/env

if [ -f /Users/simon/google-cloud-sdk/path.zsh.inc ]; then
  source '/Users/simon/google-cloud-sdk/path.zsh.inc'
fi
if [ -f /Users/simon/google-cloud-sdk/completion.zsh.inc ]; then
  source '/Users/simon/google-cloud-sdk/completion.zsh.inc'
fi
