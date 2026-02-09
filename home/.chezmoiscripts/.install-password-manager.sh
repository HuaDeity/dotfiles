#!/usr/bin/env bash

# exit immediately if doppler is already in $PATH
type doppler >/dev/null 2>&1 && exit

case "$(uname -s)" in
Darwin)
  brew install doppler
  ;;
Linux)
  flox install -d "$HOME" doppler
  ;;
*)
  echo "unsupported OS"
  exit 1
  ;;
esac
