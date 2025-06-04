set -a
source <(doppler secrets download --no-file --format env -p dotfiles -c dev_personal 2>/dev/null)
set +a
