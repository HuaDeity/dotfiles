function set_flavor
    set -l valid_flavors latte frappe macchiato mocha

    # If parameter provided, try to use it
    if test (count $argv) -gt 0
        set -l requested_flavor $argv[1]

        # Check if requested flavor is valid
        if contains $requested_flavor $valid_flavors
            set -gx LC_FLAVOR $requested_flavor
        else
            echo "Invalid flavor '$requested_flavor'. Valid options: $valid_flavors"
            return 1
        end
    else
        if not set -q LC_FLAVOR
            # No parameter - use auto-detection (original logic)
            if test (uname -s) = Darwin
                if defaults read -g AppleInterfaceStyle &>/dev/null
                    # flavor Dark
                    set -gx LC_FLAVOR mocha
                else
                    # flavor Light
                    set -gx LC_FLAVOR latte
                end
            else
                # Non-macOS systems - default to dark theme
                set -gx LC_FLAVOR mocha
            end
        end
    end

    set -l first (string upper (string sub -l 1 $LC_FLAVOR))
    set -l rest (string sub -s 2 $LC_FLAVOR)
    set -gx LC_CFLAVOR "$first$rest"
end
