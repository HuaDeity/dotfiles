export GHOSTTY_RESOURCES_DIR="${GHOSTTY_RESOURCES_DIR:-$XDG_CONFIG_HOME/ghostty}"

if [[ -n $GHOSTTY_RESOURCES_DIR ]]; then
  source "$GHOSTTY_RESOURCES_DIR"/shell-integration/zsh/ghostty-integration
fi
