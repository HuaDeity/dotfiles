typeset -aU _brewcmds=(
  /opt/homebrew/bin/brew(N)
  /home/linuxbrew/.linuxbrew/bin/brew(N)
)
(( ${#_brewcmds} )) || return 1
eval "$($_brewcmds[1] shellenv)"
unset _brewcmd

HOMEBREW_NO_ANALYTICS=${HOMEBREW_NO_ANALYTICS:1}

# Add brewed Zsh to fpath
if [[ -d "$HOMEBREW_PREFIX/share/zsh/site-functions" ]]; then
  fpath+=("$HOMEBREW_PREFIX/share/zsh/site-functions")
fi

HOMEBREW_KEG_ONLY_APPS=(curl rustup sqlite)
for app in $HOMEBREW_KEG_ONLY_APPS; do
	path=($HOMEBREW_PREFIX/opt/$app/bin(N) $path)
  fpath=($HOMEBREW_PREFIX/opt/$app/share/zsh/site-functions(/N) $fpath)
done
unset HOMEBREW_KEG_ONLY_APPS

# Handle brew on multi-user Apple silicon.
if [[ "$HOMEBREW_PREFIX" == /opt/homebrew ]]; then
	# Check for GNU coreutils stat
	if stat --version &>/dev/null; then
		_brew_owner="$(stat -c "%U" "$HOMEBREW_PREFIX" 2>/dev/null)"
	else
		_brew_owner="$(stat -f "%Su" "$HOMEBREW_PREFIX" 2>/dev/null)"
	fi
	if [[ -n "$_brew_owner" ]] && [[ "$(whoami)" != "$_brew_owner" ]]; then
		alias brew="sudo -Hu '$_brew_owner' brew"
	fi
	unset _brew_owner
fi

