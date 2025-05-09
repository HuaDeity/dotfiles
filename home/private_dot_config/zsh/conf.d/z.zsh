#
# z: Customize z
#

export ZSHZ_DATA=${ZSHZ_DATA:=${XDG_DATA_HOME:-$HOME/.local/share}/z/z}
[[ -d ${ZSHZ_DATA:h} ]] || mkdir -p ${ZSHZ_DATA:h}
