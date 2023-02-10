return {
  {
    "glepnir/dashboard-nvim",
    event = "VimEnter",
    opts = {
      theme = "doom",
      config = {
        header = {
          "                                          ",
          "                                          ",
          "                                          ",
          "                                          ",
          "                                          ",
          "               ▄▄██████████▄▄             ",
          "               ▀▀▀   ██   ▀▀▀             ",
          "       ▄██▄   ▄▄████████████▄▄   ▄██▄     ",
          "     ▄███▀  ▄████▀▀▀    ▀▀▀████▄  ▀███▄   ",
          "    ████▄ ▄███▀              ▀███▄ ▄████  ",
          "   ███▀█████▀▄████▄      ▄████▄▀█████▀███ ",
          "   ██▀  ███▀ ██████      ██████ ▀███  ▀██ ",
          "    ▀  ▄██▀  ▀████▀  ▄▄  ▀████▀  ▀██▄  ▀  ",
          "       ███           ▀▀           ███     ",
          "       ██████████████████████████████     ",
          "   ▄█  ▀██  ███   ██    ██   ███  ██▀  █▄ ",
          "   ███  ███ ███   ██    ██   ███▄███  ███ ",
          "   ▀██▄████████   ██    ██   ████████▄██▀ ",
          "    ▀███▀ ▀████   ██    ██   ████▀ ▀███▀  ",
          "     ▀███▄  ▀███████    ███████▀  ▄███▀   ",
          "       ▀███    ▀▀██████████▀▀▀   ███▀     ",
          "         ▀    ▄▄▄    ██    ▄▄▄    ▀       ",
          "               ▀████████████▀             ",
          "																					 ",
        },
        center = {
          {
            icon = "  ",
            desc = "Find file",
            action = "Telescope find_files",
            key = "f",
          },
          {
            icon = "  ",
            desc = "New file",
            action = "ene | startinsert",
            key = "n",
          },
          {
            icon = "  ",
            desc = "Recent files",
            action = "Telescope oldfiles",
            key = "r",
          },
          {
            icon = "  ",
            desc = "Find text",
            action = "Telescope live_grep",
            key = "g",
          },
          {
            icon = "  ",
            desc = "Config",
            action = "e $MYVIMRC",
            key = "c",
          },
          {
            icon = "勒 ",
            desc = "Restore Session",
            action = [[:lua require("persistence").load()]],
            key = "s",
          },
          {
            icon = "鈴 ",
            desc = "Lazy",
            action = "Lazy",
            key = "l",
          },
          {
            icon = "  ",
            desc = "Quit                                    ",
            action = "qa",
            key = "q",
          },
        },
        footer = { "HuaDeity" },
      },
    },
    dependencies = { { "nvim-tree/nvim-web-devicons" } },
  },
}
