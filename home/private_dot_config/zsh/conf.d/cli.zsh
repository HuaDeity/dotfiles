if (( $+commands[atuin] )); then
  update_config_flavor "$XDG_CONFIG_HOME/atuin/config.toml"
  eval "$(atuin init zsh)"
fi

if (( $+commands[bat] )) || (( $+commands[batcat] )); then
	export READNULLCMD=batcat

	if (( $+commands[batman] )); then
		eval "$(batman --export-env)"
	fi

	if (( $+commands[batpipe] )); then
		eval "$(batpipe)"
	fi
fi

if (( $+commands[docker-language-server] )); then
	source <(docker-language-server completion zsh)
fi

if (( $+commands[jj] )); then
	source <(COMPLETE=zsh jj)
fi

if [[ OS == "Darwin" ]]; then
	[ -d "$HOME/.orbstack" ] && source $HOME/.orbstack/shell/init.zsh 2>/dev/null || :
fi

if (( $+commands[rbenv] )); then
	eval "$(rbenv init - --no-rehash zsh)"
fi

if (( $+commands[starship] )); then
	update_config_flavor "$XDG_CONFIG_HOME/starship.toml" 'palette = .*$' "palette = \"catppuccin_$flavor\""
fi

if (( $+commands[zoxide] )); then
  eval "$(zoxide init zsh)"
fi

