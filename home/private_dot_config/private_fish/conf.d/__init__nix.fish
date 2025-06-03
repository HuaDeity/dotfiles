set -gx NIX_PATH "nixpkgs=flake:nixpkgs"
set -gx NIX_PROFILES "/nix/var/nix/profiles/default /run/current-system/sw $HOME/.local/state/nix/profile"
set -gx NIX_SSL_CERT_FILE "/etc/ssl/certs/ca-certificates.crt"
set -gx NIX_USER_PROFILE_DIR "/nix/var/nix/profiles/per-user/$USER"

function _setup_nix_profile
    # Split NIX_PROFILES and build directories dynamically
    set -l nix_profile_path (string split ' ' $NIX_PROFILES)
    for profile in $nix_profile_path
        fish_add_path $profile/bin
        set TERMINFO_DIRS $profile/share/terminfo:$TERMINFO_DIRS
        set XDG_CONFIG_DIRS $profile/etc/xdg:$XDG_CONFIG_DIRS
        set XDG_DATA_DIRS $profile/share:$XDG_DATA_DIRS
    end
end

_setup_nix_profile
functions -e _setup_nix_profile
