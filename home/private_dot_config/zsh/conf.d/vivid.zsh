if (( $+commands[vivid] )); then
	export LS_COLORS="$(vivid generate catppuccin-$flavor)"
fi
