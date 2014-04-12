PS1="\[\033[1;30m\]\w\[\033[00m\]"
if [ -f ~/.git-completion.sh ]; then
  source ~/.git-completion.sh
  GIT_PS1_SHOWDIRTYSTATE=true
  GIT_PS1_SHOWUNTRACKEDFILES=true
  PS1=$PS1'\[\033[32m\]$(__git_ps1 " (%s)")\[\033[00m\]'
fi
PS1=$PS1" $ "
export PS1

export EDITOR=vim

HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000

shopt -s checkwinsize

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

case "$TERM" in
  xterm-color) color_prompt=yes;;
esac

if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
  . /etc/bash_completion
fi

