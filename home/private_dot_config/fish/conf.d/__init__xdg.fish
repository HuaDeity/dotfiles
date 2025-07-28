#
# xdg - don't pollute home
#

# docker
set -q DOCKER_CONFIG; or set -gx DOCKER_CONFIG $XDG_CONFIG_HOME/docker

# doppler
set -q DOPPLER_CONFIG_DIR; or set -gx DOPPLER_CONFIG_DIR $XDG_CONFIG_HOME/doppler

# gpg
set -q GNUPGHOME; or set -gx GNUPGHOME $XDG_DATA_HOME/gnupg
alias gpg "gpg --homedir '$GNUPGHOME'"

# gradle
set -q GRADLE_USER_HOME; or set -gx GRADLE_USER_HOME $XDG_DATA_HOME/gradle

# ncurses
set -q TERMINFO; or set -gx TERMINFO $XDG_DATA_HOME/terminfo
set TERMINFO_DIRS $TERMINFO:$TERMINFO_DIRS

# node
set -q NPM_CONFIG_USERCONFIG; or set -gx NPM_CONFIG_USERCONFIG $XDG_CONFIG_HOME/npm/npmrc
set -q NODE_REPL_HISTORY; or set -gx NODE_REPL_HISTORY $XDG_DATA_HOME/node_repl_history

# ollama
set -q OLLAMA_MODELS; or set -gx OLLAMA_MODELS $XDG_DATA_HOME/ollama/models

# python
set -q PYTHON_HISTORY; or set -gx PYTHON_HISTORY $XDG_CACHE_HOME/python/python_history
set -q IPYTHONDIR; or set -gx IPYTHONDIR $XDG_CONFIG_HOME/ipython

# rbenv
set -q RBENV_ROOT; or set -gx RBENV_ROOT $XDG_DATA_HOME/rbenv

# readline
set -q INPUTRC; or set -gx INPUTRC $XDG_CONFIG_HOME/readline/inputrc

# ruby bundler
set -q BUNDLE_USER_CONFIG; or set -gx BUNDLE_USER_CONFIG $XDG_CONFIG_HOME/bundle/config
set -q BUNDLE_USER_CACHE; or set -gx BUNDLE_USER_CACHE $XDG_CACHE_HOME/bundle
set -q BUNDLE_USER_PLUGIN; or set -gx BUNDLE_USER_PLUGIN $XDG_DATA_HOME/bundle

# rust
set -q CARGO_HOME; or set -gx CARGO_HOME $XDG_DATA_HOME/cargo
set -q RUSTUP_HOME; or set -gx RUSTUP_HOME $XDG_DATA_HOME/rustup

# screen
set -q SCREENRC; or set -gx SCREENRC $XDG_CONFIG_HOME/screen/screenrc

# sqlite
set -q SQLITE_HISTORY; or set -gx SQLITE_HISTORY $XDG_STATE_HOME/sqlite_history

# wakatime
set -q WAKATIME_HOME; or set -gx WAKATIME_HOME $XDG_CONFIG_HOME/wakatime

# wget
set -q WGETRC; or set -gx WGETRC $XDG_CONFIG_HOME/wget/wgetrc
alias wget "wget --hsts-file='$XDG_CACHE_HOME/wget-hsts'"
