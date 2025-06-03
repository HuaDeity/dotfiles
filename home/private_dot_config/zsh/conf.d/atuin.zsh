if (( $+commands[atuin] )); then
  update_config_flavor "$XDG_CONFIG_HOME/atuin/config.toml"
  eval "$(atuin init zsh)"
fi
