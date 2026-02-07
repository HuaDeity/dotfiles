set_flavor

fish_config theme choose catppuccin-mocha

set -gx BAT_THEME "Catppuccin $LC_CFLAVOR"

set -gx DELTA_FEATURES "+catppuccin-$LC_FLAVOR"

if test -f "$XDG_CONFIG_HOME/fzf/themes/catppuccin-fzf-$LC_FLAVOR.fish"
    source "$XDG_CONFIG_HOME/fzf/themes/catppuccin-fzf-$LC_FLAVOR.fish"
end

set -gx GLAMOUR_STYLE "$XDG_CONFIG_HOME/glamour/themes/catppuccin-$LC_FLAVOR.json"
alias glow="glow -s $XDG_CONFIG_HOME/glamour/themes/catppuccin-$LC_FLAVOR.json"

set -gx LG_CONFIG_FILE "$XDG_CONFIG_HOME/lazygit/config.yml,$XDG_CONFIG_HOME/lazygit/themes/$LC_FLAVOR/mauve.yml"

if command -q vivid
    set -gx LS_COLORS "$(vivid generate catppuccin-$LC_FLAVOR)"
end
