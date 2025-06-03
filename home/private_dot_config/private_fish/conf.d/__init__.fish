#
# __init__: Anything that needs to be first.
#

# Set XDG basedirs.
# https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
set -q XDG_CONFIG_HOME; or set -Ux XDG_CONFIG_HOME $HOME/.config
set -q XDG_DATA_HOME; or set -Ux XDG_DATA_HOME $HOME/.local/share
set -q XDG_STATE_HOME; or set -Ux XDG_STATE_HOME $HOME/.local/state
set -q XDG_CACHE_HOME; or set -Ux XDG_CACHE_HOME $HOME/.cache
for xdgdir in (path filter -vd $XDG_CONFIG_HOME $XDG_DATA_HOME $XDG_STATE_HOME $XDG_CACHE_HOME)
    mkdir -p $xdgdir
end

# Allow subdirs for functions and completions.
set fish_function_path (path resolve $__fish_config_dir/functions/*/) $fish_function_path
set fish_complete_path (path resolve $__fish_config_dir/completions/*/) $fish_complete_path

fish_add_path $HOME/.local/bin

set -q TERMINFO_DIRS; or set -gx TERMINFO_DIRS /usr/share/terminfo
set -q XDG_CONFIG_DIRS; or set -gx XDG_CONFIG_DIRS
set -q XDG_DATA_DIRS; or set -gx XDG_DATA_DIRS

set_flavor

set -U HOMEBREW_KEG_ONLY_APPS curl rustup
