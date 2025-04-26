#
# sudo: Easily prefix your current or previous commands with sudo by pressing esc twice.
#

# Defined shortcut keys: [Esc] [Esc]
bindkey -M emacs '\e\e' prepend-sudo
bindkey -M vicmd '\e\e' prepend-sudo
bindkey -M viins '\e\e' prepend-sudo
