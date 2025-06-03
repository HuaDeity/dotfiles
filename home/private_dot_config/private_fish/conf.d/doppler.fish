for var in (doppler secrets download --no-file --format env -p dotfiles -c dev_personal)
    set -l parts (string split -m 1 '=' $var)
    if test (count $parts) -eq 2
        set -l value $parts[2]
        # Remove surrounding quotes if they exist
        if string match -q '"*"' $value
            set value (string sub -s 2 -e -1 $value)
        end
        set -Ux $parts[1] $value
    end
end
