set_flavor

export BAT_THEME="Catppuccin $LC_CFLAVOR"

export DELTA_FEATURES="+catppuccin-$LC_FLAVOR"

[[ -f "$XDG_CONFIG_HOME/fzf/themes/catppuccin-fzf-$LC_FLAVOR.sh" ]] && source "$XDG_CONFIG_HOME/fzf/themes/catppuccin-fzf-$LC_FLAVOR.sh"

alias gitui="gitui -t catppuccin-$LC_FLAVOR.ron"

export LG_CONFIG_FILE="$XDG_CONFIG_HOME/lazygit/config.yml,$XDG_CONFIG_HOME/lazygit/themes/$LC_FLAVOR/mauve.yml"

if (( $+commands[vivid] )); then
	export LS_COLORS="$(vivid generate catppuccin-$LC_FLAVOR)"
fi
