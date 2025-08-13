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

set -gx DIRENV_LOG_FORMAT (set_color --dim)"direnv: %s"(set_color normal)

if command -q docker-language-server
    docker-language-server completion fish | source
end

switch (uname -s)
    case Darwin
        test -f ~/.orbstack/shell/init2.fish && source ~/.orbstack/shell/init2.fish
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

if command -q zoxide
    zoxide init fish | source
end
