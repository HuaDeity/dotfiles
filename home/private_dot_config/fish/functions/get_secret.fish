function get_secret
    for var in (doppler secrets download --no-file --format env -p dotfiles -c dev_personal 2>/dev/null)
        set -l parts (string split -m 1 '=' $var)
        if test (count $parts) -eq 2
            set -l value $parts[2]
            # Remove surrounding quotes if they exist
            if string match -q '"*"' $value
                set value (string sub -s 2 -e -1 $value)
            end
            if test -n "$parts[1]"
                set -gx $parts[1] $value
            end
        end
    end
    switch (uname -s)
        case Darwin
            set -gx SSH_AUTH_SOCK $HOME/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh
    end
end
