set -gx NIX_PATH "nixpkgs=flake:nixpkgs"
set -gx NIX_PROFILES "/nix/var/nix/profiles/default /run/current-system/sw /etc/profiles/per-user/$USER $XDG_STATE_HOME/nix/profile"
set -gx NIX_SSL_CERT_FILE "/etc/ssl/certs/ca-certificates.crt"
set -gx NIX_USER_PROFILE_DIR "/nix/var/nix/profiles/per-user/$USER"

function _setup_nix_profile
    # Split NIX_PROFILES and build directories dynamically
    set -l nix_profile_path (string split ' ' $NIX_PROFILES)
    for profile in $nix_profile_path
        # bin PATH
        fish_add_path --global $profile/bin

        # vendor completion
        add_completion_after_vendor "$profile/share/fish/vendor_completions.d"

        # terminfo
        prepend_if_dir TERMINFO_DIRS "$profile/share/terminfo"

        # XDG config/data dirs
        prepend_if_dir XDG_CONFIG_DIRS "$profile/etc/xdg"
        prepend_if_dir XDG_DATA_DIRS "$profile/share"
    end
end

_setup_nix_profile
functions -e _setup_nix_profile
