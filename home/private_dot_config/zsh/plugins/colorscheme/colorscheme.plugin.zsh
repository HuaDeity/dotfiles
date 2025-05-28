#
# colorscheme: change cli colorscheme
#

if [ -z "$flavor" ]; then
	export flavor=mocha
fi
export flavor_capitalized="$(tr '[:lower:]' '[:upper:]' <<< ${flavor:0:1})${flavor:1}"

if [ "$flavor" = "mocha" ]; then
	export FZF_DEFAULT_OPTS=" \
	--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
	--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
	--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"
else
	export FZF_DEFAULT_OPTS=" \
	--color=bg+:#ccd0da,bg:#eff1f5,spinner:#dc8a78,hl:#d20f39 \
	--color=fg:#4c4f69,header:#d20f39,info:#8839ef,pointer:#dc8a78 \
	--color=marker:#dc8a78,fg+:#4c4f69,prompt:#8839ef,hl+:#d20f39"
fi

export BAT_THEME="Catppuccin $flavor_capitalized"
export LG_CONFIG_FILE="$HOME/.config/lazygit/config.yml,$HOME/.config/lazygit/themes/$flavor/mauve.yml"

if [ "$ZSH_THEME" = "starship auto" ]; then
    zstyle ':zephyr:plugin:prompt' theme starship $flavor
    ZSH_THEME=(starship $flavor)
fi

# gitui
alias gitui="gitui -t catppuccin-$flavor.ron"
