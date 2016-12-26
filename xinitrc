[[ -f ~/.xmodmap ]] && xmodmap ~/.xmodmap
[[ -f ~/.xresources ]] && xrdb -merge -I$HOME ~/.xresources
exec i3
