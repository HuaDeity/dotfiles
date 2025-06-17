#
# __init__: Anything that needs to be first.
#

# Set XDG basedirs.
# https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
set -q XDG_CONFIG_HOME; or set -gx XDG_CONFIG_HOME $HOME/.config
set -q XDG_DATA_HOME; or set -gx XDG_DATA_HOME $HOME/.local/share
set -q XDG_STATE_HOME; or set -gx XDG_STATE_HOME $HOME/.local/state
set -q XDG_CACHE_HOME; or set -gx XDG_CACHE_HOME $HOME/.cache
for xdgdir in (path filter -vd $XDG_CONFIG_HOME $XDG_DATA_HOME $XDG_STATE_HOME $XDG_CACHE_HOME)
    mkdir -p $xdgdir
end

# Set editor variables.
set -gx EDITOR nvim
if set -q SSH_CONNECTION
    set -gx VISUAL nvim
else
    set -gx VISUAL zed
end
set -gx PAGER less

# Auto Proxy
set -g FISH_PROXY_AUTO yes
set -g FISH_PROXY_PLUGINS shell nix

switch (uname -s)
    case Darwin
        # Set browser on macOS.
        set -q BROWSER; or set -gx BROWSER open
        # SSH Agent
        set -gx SSH_AUTH_SOCK $HOME/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh
    case Linux
        # Proxy
        set -g FISH_PROXY_MIXED "192.168.103.42:7878"
end

fish_add_path $HOME/.local/bin

# Allow subdirs for functions and completions.
set fish_function_path (path resolve $__fish_config_dir/functions/*/) $fish_function_path
set fish_complete_path (path resolve $__fish_config_dir/completions/*/) $fish_complete_path

set -q TERMINFO_DIRS; or set -gx TERMINFO_DIRS /usr/share/terminfo
set -q XDG_CONFIG_DIRS; or set -gx XDG_CONFIG_DIRS
set -q XDG_DATA_DIRS; or set -gx XDG_DATA_DIRS

set -g hydro_fetch true
set -g hydro_multiline true

set_flavor
