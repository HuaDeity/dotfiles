function set_flavor
    set -l valid_flavors latte frappe macchiato mocha

    # If parameter provided, try to use it
    if test (count $argv) -gt 0
        set -l requested_flavor $argv[1]

        # Check if requested flavor is valid
        if contains $requested_flavor $valid_flavors
            set -gx flavor $requested_flavor
        else
            echo "Invalid flavor '$requested_flavor'. Valid options: $valid_flavors"
            return 1
        end
    else
        # No parameter - use auto-detection (original logic)
        if test (uname -s) = Darwin
            if defaults read -g AppleInterfaceStyle &>/dev/null
                # flavor Dark
                set -gx flavor mocha
            else
                # flavor Light
                set -gx flavor latte
            end
        else
            # Non-macOS systems - default to dark theme
            set -gx flavor mocha
        end
    end

    set -gx flavor_capitalized (string upper (string sub -l 1 $flavor))(string sub -s 2 $flavor)
end
