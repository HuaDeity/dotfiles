set -g fish_greeting

set -g fish_key_bindings fish_hybrid_key_bindings

set -g fish_transient_prompt 1

## fancy ctrl z
bind ctrl-z 'fg 2>/dev/null; commandline -f repaint'

fish_add_path --global $HOME/.local/bin

get_secret
