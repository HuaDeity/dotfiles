function set_flavor
    set -l valid_flavors latte frappe macchiato mocha

    # If parameter provided, try to use it
    if test (count $argv) -gt 0
        set -l requested_flavor $argv[1]

        # Check if requested flavor is valid
        if contains $requested_flavor $valid_flavors
            set -U flavor $requested_flavor
        else
            echo "Invalid flavor '$requested_flavor'. Valid options: $valid_flavors"
            return 1
        end
    else
        # No parameter - use auto-detection (original logic)
        if test (uname -s) = Darwin
            if defaults read -g AppleInterfaceStyle &>/dev/null
                # flavor Dark
                set -U flavor mocha
            else
                # flavor Light
                set -U flavor latte
            end
        else
            # Non-macOS systems - default to dark theme
            set -U flavor mocha
        end
    end

    set -U flavor_capitalized (string upper (string sub -l 1 $flavor))(string sub -s 2 $flavor)
end
