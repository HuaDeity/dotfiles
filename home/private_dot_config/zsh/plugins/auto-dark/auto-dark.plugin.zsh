# Auto Dark for CLI on macOS
if $(defaults read -g AppleInterfaceStyle &>/dev/null); then
	# flavor Dark
	export flavor=mocha
else
	# flavor Light
	export flavor=latte
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
	ssh -t "$host_target" "export flavor=$flavor; /nas/wangyizun/.local/state/nix/profile/bin/zsh -l" "$@"
}
