if (( $+commands[bat] )) || (( $+commands[batcat] )) || (( $+commands[batman] )); then
  export BAT_THEME="Catppuccin $flavor_capitalized"

  if (( $+commands[bat] )); then
    alias cat="bat"
  elif (( $+commands[batcat] )); then
    alias cat="batcat"
  fi

  if (( $+commands[batman] )); then
    eval "$(batman --export-env)"
  fi
fi
