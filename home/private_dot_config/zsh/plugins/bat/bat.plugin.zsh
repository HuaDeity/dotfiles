if (( $+commands[bat] )); then
	alias cat="bat"
elif (( $+commands[batcat] )); then
	alias cat="batcat"
fi

if (( $+commands[batman] )); then
  source <(batman --export-env)
fi
