ZSH_AUTOSUGGEST_STRATEGY=( abbreviations $ZSH_AUTOSUGGEST_STRATEGY )

bindkey -M viins " " abbr-expand-and-insert
bindkey -M viins "^ " magic-space
# bindkey -M viins "^M" abbr-expand-and-accept
