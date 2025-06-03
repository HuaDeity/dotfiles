#
# xdg - don't pollute home
#

#
# Shell utils
#

# ncurses

set -q TERMINFO; or set -gx TERMINFO $XDG_DATA_HOME/terminfo
set TERMINFO_DIRS $TERMINFO:$TERMINFO_DIRS
