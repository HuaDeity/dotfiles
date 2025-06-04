if command -q bat; or command -q batcat
    set -gx BAT_THEME "Catppuccin $flavor_capitalized"

    if command -q bat
        alias cat="bat"
    else if command -q batcat
        alias cat="batcat"
    end

    if command -q batman
        batman --export-env | source
    end

    if command -q batpipe
        eval (batpipe)
    end
end
