if command -q lazygit
    set -gx LG_CONFIG_FILE "$XDG_CONFIG_HOME/lazygit/config.yml,$XDG_CONFIG_HOME/lazygit/themes/$flavor/mauve.yml"
end
