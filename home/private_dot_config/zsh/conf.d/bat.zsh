if (( $+commands[bat] )) || (( $+commands[batcat] )); then
  export BAT_THEME="Catppuccin $flavor_capitalized"

  if (( $+commands[bat] )); then
    alias cat="bat"
    export READNULLCMD=bat
  elif (( $+commands[batcat] )); then
    alias cat="batcat"
    export READNULLCMD=batcat
  fi

  alias -g -- -h='-h 2>&1 | cat --language=help --style=plain'
  alias -g -- --help='--help 2>&1 | cat --language=help --style=plain'

  if (( $+commands[batman] )); then
    eval "$(batman --export-env)"
  fi

  if (( $+commands[batpipe] )); then
    eval "$(batpipe)"
  fi
fi
