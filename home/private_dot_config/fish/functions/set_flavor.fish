function set_flavor
    set -l valid_flavors latte frappe macchiato mocha

    # If parameter provided, try to use it
    if test (count $argv) -gt 0
        set -l requested_flavor $argv[1]

        # Check if requested flavor is valid
        if contains $requested_flavor $valid_flavors
            set -Ux LC_FLAVOR $requested_flavor
        else
            echo "Invalid flavor '$requested_flavor'. Valid options: $valid_flavors"
            return 1
        end
    else
        # No parameter - use auto-detection (original logic)
        if test (uname -s) = Darwin
            if defaults read -g AppleInterfaceStyle &>/dev/null
                # flavor Dark
                set -Ux LC_FLAVOR mocha
            else
                # flavor Light
                set -Ux LC_FLAVOR latte
            end
        else
            # Non-macOS systems - default to dark theme
            set -Ux LC_FLAVOR mocha
        end
    end

    set -Ux LC_CFLAVOR (string upper (string sub -l 1 $LC_FLAVOR))(string sub -s 2 $LC_FLAVOR)
end
