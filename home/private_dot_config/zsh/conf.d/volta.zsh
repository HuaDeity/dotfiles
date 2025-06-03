if (( $+commands[volta] )); then
	export VOLTA_HOME="$XDG_DATA_HOME/volta"
	path=($VOLTA_HOME/bin(N) $path)
fi
