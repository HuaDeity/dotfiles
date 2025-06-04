switch (uname -s)
    case Darwin
        set -l __hb_cnf_handler (brew --repository)"/Library/Taps/homebrew/homebrew-command-not-found/handler.fish"
        if test -f $__hb_cnf_handler
            source $__hb_cnf_handler
        end
    case Linux
        set -l __nix_cnf_handler "$XDG_STATE_HOME/nix/profile/etc/profile.d/command-not-found.sh"
        if test -f $__nix_cnf_handler
            function __fish_command_not_found_handler --on-event fish_command_not_found
                bash -c "source $__nix_cnf_handler && command_not_found_handle $argv"
            end
        end
end
