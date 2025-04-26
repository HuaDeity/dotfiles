#!/bin/sh

case "$(uname -s)" in
Darwin)
    brew install doppler
    ;;
Linux)
    nix shell "nixpkgs#doppler"
    ;;
*)
    echo "unsupported OS"
    exit 1
    ;;
esac
