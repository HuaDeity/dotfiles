if command -q fzf
    set -l theme_file "$XDG_CONFIG_HOME/fzf/themes/catppuccin-fzf-$flavor.fish"
    if test -f "$theme_file"
        source "$theme_file"
    end
    # Set up fzf key bindings
    fzf --fish | source
end
