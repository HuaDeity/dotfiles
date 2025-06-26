set -g fish_key_bindings fish_hybrid_key_bindings

set -U fish_greeting

## fancy ctrl z
bind ctrl-z 'fg 2>/dev/null; commandline -f repaint'

get_secret
