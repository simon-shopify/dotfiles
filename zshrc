export PROMPT="%F{magenta}%n%F{default} on %F{yellow}$(uname | awk '{ print tolower($0) }')%F{default} %F{magenta}%~%F{default}
%(?..%F{red}%?%F{default} )$ "
export PROMPT="%(?..%F{red}%?%F{default} )%F{magenta}$%F{default} "
export TERM=xterm
export LANG="en_US.UTF-8"
export EDITOR=emacsclient
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

[ -f /opt/dev/dev.sh ] && source /opt/dev/dev.sh
[ -f $HOME/.cargo/env ] && source $HOME/.cargo/env

source "$HOME/.minikube-completion"
if [ -f /Users/simon/google-cloud-sdk/path.zsh.inc ]; then
  source '/Users/simon/google-cloud-sdk/path.zsh.inc'
fi
if [ -f /Users/simon/google-cloud-sdk/completion.zsh.inc ]; then
  source '/Users/simon/google-cloud-sdk/completion.zsh.inc'
fi

function jt { ruby /Users/simon/src/github.com/graalvm/truffleruby/tool/jt.rb "$@"; }
