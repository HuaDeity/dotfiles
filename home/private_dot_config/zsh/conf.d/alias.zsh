if (( $+commands[bat] )) || (( $+commands[batcat] )); then
  if (( $+commands[bat] )); then
    alias cat="bat"
  elif (( $+commands[batcat] )); then
    alias cat="batcat"
  fi

  alias -g -- -h='-h 2>&1 | cat --language=help --style=plain'
  alias -g -- --help='--help 2>&1 | cat --language=help --style=plain'
fi

if (( $+commands[eza] )); then
	alias ls='eza --group-directories-first'
fi

alias grt='cd "$(git rev-parse --show-toplevel || echo .)"'

if [[ "$OSTYPE" == darwin* ]]; then
  alias keka="/Applications/Keka.app/Contents/MacOS/Keka --cli"
  alias gtower='gittower $(git rev-parse --show-toplevel)'
fi
