if status is-interactive
    # Commands to run in interactive sessions can go here
    if ! functions --query fisher
        curl -sL https://git.io/fisher | source && fisher update
    end
end

set -g fish_key_bindings fish_hybrid_key_bindings

set -U fish_greeting
