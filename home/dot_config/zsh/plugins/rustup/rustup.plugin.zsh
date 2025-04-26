# Rustup is keg-only
[[ -d "${HOMBREW_PREFIX:-/opt/homebrew}" ]] || return

: ${HOMBREW_PREFIX:=/opt/homebrew}
path=(
  $HOMBREW_PREFIX/opt/rustup/bin(N)
  $path
)
