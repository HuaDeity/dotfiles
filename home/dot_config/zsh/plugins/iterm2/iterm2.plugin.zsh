if [[ $TERM_PROGRAM != "WarpTerminal" ]]; then
  export ITERM_ENABLE_SHELL_INTEGRATION_WITH_TMUX=YES
  test -e "${0:A:h}/iterm2_shell_integration.zsh" && source "${0:A:h}/iterm2_shell_integration.zsh"
fi

