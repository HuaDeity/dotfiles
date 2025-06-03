set -q HOMEBREW_KEG_ONLY_APPS || set -U HOMEBREW_KEG_ONLY_APPS curl
for app in $HOMEBREW_KEG_ONLY_APPS
    if test -d "$HOMEBREW_PREFIX/opt/$app"
        set --append fish_complete_path "$HOMEBREW_PREFIX/opt/$app/share/fish/vendor_completions.d"
    end
end
