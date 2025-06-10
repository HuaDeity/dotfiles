if command -q vivid
    set -gx LS_COLORS "$(vivid generate catppuccin-$flavor)"
end
