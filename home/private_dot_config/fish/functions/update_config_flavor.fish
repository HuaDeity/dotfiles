function update_config_flavor
    set config_file $argv[1]
    set pattern (string length --quiet $argv[2]; and echo $argv[2]; or echo "latte|mocha")
    set -q LC_FLAVOR; or set -l LC_FLAVOR mocha
    set replacement (string length --quiet $argv[3]; and echo $argv[3]; or echo $LC_FLAVOR)

    if test -f $config_file
        if test (uname) = Darwin
            sed -i '' -E "s/$pattern/$replacement/g" $config_file
        else
            sed -i -E "s/$pattern/$replacement/g" $config_file
        end
    end
end
