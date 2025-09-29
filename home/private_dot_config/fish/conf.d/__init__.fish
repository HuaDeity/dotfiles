set -q TERMINFO_DIRS; or set -gx TERMINFO_DIRS /usr/share/terminfo
set -q XDG_CONFIG_DIRS; or set -gx XDG_CONFIG_DIRS
set -q XDG_DATA_DIRS; or set -gx XDG_DATA_DIRS
set -q XDG_CONFIG_HOME; or set -gx XDG_CONFIG_HOME $HOME/.config
set -q XDG_DATA_HOME; or set -gx XDG_DATA_HOME $HOME/.local/share
set -q XDG_STATE_HOME; or set -gx XDG_STATE_HOME $HOME/.local/state
set -q XDG_CACHE_HOME; or set -gx XDG_CACHE_HOME $HOME/.cache
for xdgdir in (path filter -vd $XDG_CONFIG_HOME $XDG_DATA_HOME $XDG_STATE_HOME $XDG_CACHE_HOME)
    mkdir -p $xdgdir
end

set -gx EDITOR nvim
if set -q SSH_CONNECTION
    set -gx VISUAL nvim
else
    set -gx VISUAL zed -w
end
set -gx PAGER less

set -g FISH_PROXY_AUTO yes
set -g FISH_PROXY_PLUGINS shell

switch (uname -s)
    case Darwin
        set -q BROWSER; or set -gx BROWSER open
    case Linux
        set -g FISH_PROXY_MIXED "192.168.103.57:7878"
end

set -g hydro_multiline true

# Allow subdirs for functions and completions.
set fish_function_path (path resolve $__fish_config_dir/functions/*/) $fish_function_path
set fish_complete_path (path resolve $__fish_config_dir/completions/*/) $fish_complete_path
