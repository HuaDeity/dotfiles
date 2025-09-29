set brewcmds (
    path filter \
        /opt/homebrew/bin/brew \
        /home/linuxbrew/.linuxbrew/bin/brew \
    )
if test (count $brewcmds) -eq 0
    return 1
end
$brewcmds[1] shellenv | source
set -e brewcmds

set -q HOMEBREW_NO_ANALYTICS || set -gx HOMEBREW_NO_ANALYTICS 1

add_completion_after_vendor "$HOMEBREW_PREFIX/share/fish/vendor_completions.d"

# Add keg-only apps
set -q HOMEBREW_KEG_ONLY_APPS; or set -g HOMEBREW_KEG_ONLY_APPS curl rustup sqlite
for app in $HOMEBREW_KEG_ONLY_APPS
    if test -d "$HOMEBREW_PREFIX/opt/$app"
        fish_add_path --global "$HOMEBREW_PREFIX/opt/$app/bin"
        add_completion_after_vendor "$HOMEBREW_PREFIX/opt/$app/share/fish/vendor_completions.d"
    end
end
set -e HOMEBREW_KEG_ONLY_APPS

# If the brew path is owned by another user, wrap it so brew commands
# are executed as the brew owner.
if stat --version &>/dev/null
    # We have GNU stat (Linux)
    set -gx HOMEBREW_OWNER (stat -c "%U" "$HOMEBREW_PREFIX" 2> /dev/null)
else
    # We have BSD stat (macOS)
    set -gx HOMEBREW_OWNER (stat -f "%Su" "$HOMEBREW_PREFIX" 2> /dev/null)
end
if test $HOMEBREW_OWNER != (whoami)
    function brew --description 'Wrap brew with sudo for multi-user systems'
        sudo -Hu $HOMEBREW_OWNER brew $argv
    end
end
