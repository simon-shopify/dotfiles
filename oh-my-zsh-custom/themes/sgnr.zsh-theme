local return_code="%(?..%{$fg[red]%}%?%{$reset_color%} )"

local user='%{$terminfo[bold]$fg[magenta]%}%n%{$reset_color%}'
local current_dir='%{$terminfo[bold]$fg[yellow]%}%~%{$reset_color%}'

PROMPT="${user} on $(uname | awk '{ print tolower($0) }') ${current_dir}
%B${return_code}λ%b "
