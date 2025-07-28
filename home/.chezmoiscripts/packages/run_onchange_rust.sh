#!/usr/bin/env bash

if command -v "rustup" &>/dev/null; then
  rustup default stable
  if ! rust-analyzer --version &>/dev/null; then
    rustup component add rust-analyzer
  fi
  rustup update
fi
