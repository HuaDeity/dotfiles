set -gx NIX_PATH "nixpkgs=flake:nixpkgs"
set -gx NIX_PROFILES "/nix/var/nix/profiles/default /run/current-system/sw $XDG_STATE_HOME/nix/profile"
set -gx NIX_SSL_CERT_FILE "/etc/ssl/certs/ca-certificates.crt"
set -gx NIX_USER_PROFILE_DIR "/nix/var/nix/profiles/per-user/$USER"
set -a fish_complete_path "/nix/var/nix/profiles/default/share/fish/vendor_completions.d"

function _setup_nix_profile
    # Split NIX_PROFILES and build directories dynamically
    set -l nix_profile_path (string split ' ' $NIX_PROFILES)
    for profile in $nix_profile_path
        if test "$profile" = "$XDG_STATE_HOME/nix/profile"
            fish_add_path --global $profile/bin
        else
            fish_add_path --path $profile/bin
        end
        set TERMINFO_DIRS $profile/share/terminfo:$TERMINFO_DIRS
        set XDG_CONFIG_DIRS $profile/etc/xdg:$XDG_CONFIG_DIRS
        set XDG_DATA_DIRS $profile/share:$XDG_DATA_DIRS
    end
end

_setup_nix_profile
functions -e _setup_nix_profile
