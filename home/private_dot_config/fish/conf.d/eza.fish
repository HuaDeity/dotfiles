if command -q eza
    set -gx EZA_CONFIG_DIR $XDG_CONFIG_HOME/eza
    alias ls='eza --group-directories-first'
end
