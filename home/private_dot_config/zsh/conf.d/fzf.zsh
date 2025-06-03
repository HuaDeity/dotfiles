if (( $+commands[fzf] )); then
	local theme_file="$XDG_CONFIG_HOME/fzf/themes/catppuccin-fzf-$flavor.sh"
	[[ -f "$theme_file" ]] && source "$theme_file"
fi
