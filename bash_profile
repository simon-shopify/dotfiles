case "$-" in
*i*)
  if [ -r "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
  fi
  ;;
esac

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

