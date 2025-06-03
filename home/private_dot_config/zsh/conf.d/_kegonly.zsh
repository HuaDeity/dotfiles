zstyle -a ':zephyr:plugin:homebrew' 'keg-only-brews' '_kegonly' \
  || _kegonly=(curl)
for _keg in $_kegonly; do
  path=($HOMEBREW_PREFIX/opt/${_keg}/bin(N) $path)
done
unset _keg{,only}
