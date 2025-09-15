if command -q atuin
    update_config_flavor "$XDG_CONFIG_HOME/atuin/config.toml"
    atuin init fish | source
end

if command -q batman
    batman --export-env | source
end

if command -q batpipe
    batpipe | source
end

if command -q cargo
    fish_add_path --global $XDG_DATA_HOME/cargo/bin
end

if command -q direnv
    set -gx DIRENV_LOG_FORMAT (set_color --dim)"direnv: %s"(set_color normal)
    direnv hook fish | source
end

if command -q docker-language-server
    docker-language-server completion fish | source
end

if command -q nvitop && command -q nixglhost
    function nvitop
        nixglhost nvitop $argv
    end
end

switch (uname -s)
    case Darwin
        fish_add_path --global --append $HOME/.orbstack/bin
end

if command -q rbenv
    status is-interactive; and rbenv init - --no-rehash fish | source
end

if command -q starship
    update_config_flavor "$XDG_CONFIG_HOME/starship.toml" 'palette = .*$' "palette = \"catppuccin_$flavor\""
    function starship_transient_prompt_func
        starship module character
    end
    function starship_transient_rprompt_func
        starship module time
    end
    starship init fish | source
    enable_transience
end

if command -q volta
    set -gx VOLTA_HOME $XDG_DATA_HOME/volta
    fish_add_path --global $VOLTA_HOME/bin
end

if command -q zoxide
    zoxide init fish | source
end
