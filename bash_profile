case "$-" in
*i*)
  if [ -r "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
  fi 
  ;;
esac

