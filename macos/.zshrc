#export PATH="/usr/local/opt/node@14/bin:$PATH"

#export PATH="/usr/local/opt/python@3.8/bin:$PATH"
export SAM_CLI_TELEMETRY=0
#export https_proxy=
#export no_proxy='localhost'

bindkey -v

autoload -U colors && colors

#red, blue, green, cyan, yellow, magenta, black, & white
PS1="%{$fg[red]%}%n%{$reset_color%}@%{$fg[blue]%}%m %{$fg[white]%}%~ %{$reset_color%}%% "
