if command -q bat
    set -gx MANPAGER "bat -plman"
end

if command -q cargo
    fish_add_path --global $XDG_DATA_HOME/cargo/bin
end

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f $HOME/.conda/bin/conda
    eval $HOME/.conda/bin/conda "shell.fish" hook $argv | source
else
    if test -f "$HOME/.conda/etc/fish/conf.d/conda.fish"
        . "$HOME/.conda/etc/fish/conf.d/conda.fish"
    else
        set -x PATH "$HOME/.conda/bin" $PATH
    end
end
# <<< conda initialize <<<

if command -q direnv
    set -gx DIRENV_LOG_FORMAT (set_color --dim)"direnv: %s"(set_color normal)
    direnv hook fish | source
end

if command -q docker-language-server
    docker-language-server completion fish | source
end

if command -q nixglhost
    set -gx NIXGL_HOST_CACHE_DIR "/home/wangyizun/.cache/nixglhost"
end

if command -q nvitop && command -q nixglhost
    function nvitop
        nixglhost nvitop $argv
    end
end

if command -q zoxide
    zoxide init fish | source
end
