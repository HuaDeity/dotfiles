if (( $+commands[eza] )); then
	export EZA_CONFIG_DIR=$XDG_CONFIG_HOME/eza
	# export EZA_COLORS='da=1;34:gm=1;34:Su=1;34'
	alias ls='eza --group-directories-first'
fi
