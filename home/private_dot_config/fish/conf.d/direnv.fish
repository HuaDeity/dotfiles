if command -q direnv
    set -gx DIRENV_LOG_FORMAT (set_color --dim)"direnv: %s"(set_color normal)
    direnv hook fish | source
end
