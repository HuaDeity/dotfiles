if command -q starship
    update_config_flavor "$XDG_CONFIG_HOME/starship/config.toml" 'palette = .*$' "palette = \"catppuccin_$flavor\""
    # function starship_transient_prompt_func
    #     starship module character
    # end
    # function starship_transient_rprompt_func
    #     starship module time
    # end
    # starship init fish | source
    # enable_transience
end
