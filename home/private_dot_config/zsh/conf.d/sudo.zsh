#
# sudo: Easily prefix your current or previous commands with sudo by pressing esc twice.
#

# Defined shortcut keys: [Esc] [Esc]
bindkey -M emacs "^[^[" prepend-sudo
bindkey -M vicmd "^[^[" prepend-sudo
bindkey -M viins "^[^[" prepend-sudo
