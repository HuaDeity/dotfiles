#
# direnv: Configure direnv.
#

if (( $+commands[direnv] )); then
  source <(direnv hook zsh)
fi
