## Platforms with a built-in command-not-found handler init file

if [[ OS == "Darwin" ]]; then
	HB_CNF_HANDLER="$(brew --repository)/Homebrew/command-not-found/handler.sh"
	if [ -f "$HB_CNF_HANDLER" ]; then
		source "$HB_CNF_HANDLER";
	fi
else
	NIX_CNF_HANDLER="$XDG_STATE_HOME/nix/profile/etc/profile.d/command-not-found.sh"
	if [ -f "$NIX_CNF_HANDLER" ]; then
		source "$NIX_CNF_HANDLER";
	fi
fi

