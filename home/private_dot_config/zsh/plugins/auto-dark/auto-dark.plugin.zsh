# Auto Dark for CLI on macOS
if $(defaults read -g AppleInterfaceStyle &>/dev/null); then
	# flavour Dark
	export flavour=mocha
else
	# flavour Light
	export flavour=latte
fi

colorssh() {
	if [[ -z "$1" ]]; then
		echo "Usage: colorssh <user@host_or_alias> [command...]"
		return 1
	fi

	local host_target="$1" # Capture the first argument as the host
	shift # Remove the first argument (host) from the argument list

	# The -t flag is crucial for an interactive session
	# The double quotes around the remote command ensure local variable expansion
	# "$@" now contains any remaining arguments (the remote command)
	ssh -t "$host_target" "export flavour=$flavour; /nas/wangyizun/.local/state/nix/profile/bin/zsh -l" "$@"
}
