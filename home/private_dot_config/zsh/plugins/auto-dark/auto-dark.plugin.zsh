# Auto Dark for CLI on macOS
if $(defaults read -g AppleInterfaceStyle &>/dev/null); then
	# flavour Dark
	export flavour=mocha
else
	# flavour Light
	export flavour=latte
fi
