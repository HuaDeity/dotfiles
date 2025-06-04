switch (uname -s)
    case Darwin
        set -l __hb_cnf_handler (brew --repository)"/Library/Taps/homebrew/homebrew-command-not-found/handler.fish"
        if test -f $__hb_cnf_handler
            source $__hb_cnf_handler
        end
end
