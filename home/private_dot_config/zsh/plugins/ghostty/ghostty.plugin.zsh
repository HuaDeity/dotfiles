export GHOSTTY_RESOURCES_DIR="${GHOSTTY_RESOURCES_DIR:-$XDG_CONFIG_HOME/ghostty}"
export GHOSTTY_SHELL_FEATURES="${GHOSTTY_SHELL_FEATURES:-cursor,sudo,title}"

if [[ -n $GHOSTTY_RESOURCES_DIR ]]; then
  source "$GHOSTTY_RESOURCES_DIR"/shell-integration/zsh/ghostty-integration
fi
