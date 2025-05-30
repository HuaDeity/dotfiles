#
# colorscheme: change cli colorscheme
#

if [ -z "$flavor" ]; then
	export flavor=mocha
fi
export flavor_capitalized="$(tr '[:lower:]' '[:upper:]' <<< ${flavor:0:1})${flavor:1}"

update_config_flavor() {
	local config_file="$1"
	local pattern="${2:-latte|mocha}"
	local replacement="${3:-$flavor}"
	if [ -f "$config_file" ]; then
		if is-macos; then
			sed -i '' -E "s/$pattern/$replacement/g" "$config_file"
		else
			sed -i -E "s/$pattern/$replacement/g" "$config_file"
		fi
	fi
}

# atuin
update_config_flavor "$XDG_CONFIG_HOME/atuin/config.toml"

# bat
export BAT_THEME="Catppuccin $flavor_capitalized"

# delta
update_config_flavor "$XDG_CONFIG_HOME/delta/delta.gitconfig"

# fzf
source $XDG_CONFIG_HOME/fzf/themes/catppuccin-fzf-$flavor.sh

# gitui
alias gitui="gitui -t catppuccin-$flavor.ron"

# lazygit
export LG_CONFIG_FILE="$HOME/.config/lazygit/config.yml,$HOME/.config/lazygit/themes/$flavor/mauve.yml"

# starship
update_config_flavor "$XDG_CONFIG_HOME/starship/config.toml" 'palette = .*$' "palette = \"catppuccin_$flavor\""

# tmux
# if [[ "$TMUX" != "" ]]; then
# 	tmux set -g @catppuccin_flavor "$flavor"
# 	tmux set -g @catppuccin_reset "true"
# 	tmux source "$TMUX_CONF_DIR/plugins/catppuccin/tmux.conf.before"
# 	tmux run "$TMUX_PLUGIN_MANAGER_PATH/tmux-catppuccin/catppuccin.tmux"
# 	tmux source "$TMUX_CONF_DIR/plugins/catppuccin/tmux.conf.after"
# fi
