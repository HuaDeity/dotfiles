if (( $+commands[starship] )); then
	update_config_flavor "$XDG_CONFIG_HOME/starship/config.toml" 'palette = .*$' "palette = \"catppuccin_$flavor\""
fi
