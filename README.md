# dotfiles

HuaDeity's dotfiles, managed with [`chezmoi`](https://github.com/twpayne/chezmoi).

Install them with:

```bash
chezmoi init HuaDeity
```

Personal secrets are stored in KDBX format and you'll need the [KeePassXC](https://keepassxc.org) installed.

It is only perfectly used in macOS at the moment, my primary platform.
I will adapt it to Windows and WSL in the future.

For macOS platform, it will use [Homebrew](https://brew.sh) to install tools, you can check it in [home/.chezmoiscripts/darwin](https://github.com/HuaDeity/dotfiles/blob/main/home/.chezmoiscripts/darwin/run_onchange_before_install-packages.sh.tmpl). And it will set configs for the following tools:

- conda
- git
- ideaVim
- lazygit
- neovim
- powerlevel10k
- ssh
- tmux
- wakatime
- zsh

And it will also download some external tools, like oh-my-zsh and themes, you can chack it in [home/.chezmoiexternal.toml.tmpl](https://github.com/HuaDeity/dotfiles/blob/main/home/.chezmoiexternal.toml.tmpl).

I use [catppuccin](https://github.com/catppuccin/catppuccin) themes for all my tools. And my zsh config will automatically set light/dark(latte/mocha) themes based on the system appearance.
