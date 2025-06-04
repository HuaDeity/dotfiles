#
# xdg - don't pollute home
#

# docker
export DOCKER_CONFIG="${DOCKER_CONFIG:-$XDG_CONFIG_HOME/docker}"

# gpg
export GNUPGHOME="${GNUPGHOME:-$XDG_DATA_HOME/gnupg}"
alias gpg="gpg --homedir '$GNUPGHOME'"

# gradle
export GRADLE_USER_HOME="${GRADLE_USER_HOME:-$XDG_DATA_HOME/gradle}"

# ncurses
export TERMINFO="${TERMINFO:-$XDG_DATA_HOME/terminfo}"
TERMINFO_DIRS="$TERMINFO:$TERMINFO_DIRS"

# node
export NPM_CONFIG_USERCONFIG="${NPM_CONFIG_USERCONFIG:-$XDG_CONFIG_HOME/npm/npmrc}"
export NODE_REPL_HISTORY="${NODE_REPL_HISTORY:-$XDG_DATA_HOME/node_repl_history}"

# ollama
export OLLAMA_MODELS="${OLLAMA_MODELS:-$XDG_DATA_HOME/ollama/models}"

# python
export PYTHON_HISTORY="${PYTHON_HISTORY:-$XDG_CACHE_HOME/python/python_history}"
export IPYTHONDIR="${IPYTHONDIR:-$XDG_CONFIG_HOME/ipython}"

# rbenv
export RBENV_ROOT="${RBENV_ROOT:-$XDG_DATA_HOME/rbenv}"

# readline
export INPUTRC="${INPUTRC:-$XDG_CONFIG_HOME/readline/inputrc}"

# ruby bundler
export BUNDLE_USER_CONFIG="${BUNDLE_USER_CONFIG:-$XDG_CONFIG_HOME/bundle/config}"
export BUNDLE_USER_CACHE="${BUNDLE_USER_CACHE:-$XDG_CACHE_HOME/bundle}"
export BUNDLE_USER_PLUGIN="${BUNDLE_USER_PLUGIN:-$XDG_DATA_HOME/bundle}"

# rust
export CARGO_HOME="${CARGO_HOME:-$XDG_DATA_HOME/cargo}"
export RUSTUP_HOME="${RUSTUP_HOME:-$XDG_DATA_HOME/rustup}"

# screen
export SCREENRC="${SCREENRC:-$XDG_CONFIG_HOME/screen/screenrc}"

# sqlite
export SQLITE_HISTORY="${SQLITE_HISTORY:-$XDG_STATE_HOME/sqlite_history}"

# wakatime
export WAKATIME_HOME="${WAKATIME_HOME:-$XDG_CONFIG_HOME/wakatime}"

# wget
export WGETRC="${WGETRC:-$XDG_CONFIG_HOME/wget/wgetrc}"
alias wget="wget --hsts-file='$XDG_CACHE_HOME/wget-hsts'"

