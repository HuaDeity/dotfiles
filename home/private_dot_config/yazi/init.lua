require("session"):setup {
  sync_yanked = true,
}

require("mime-ext.local"):setup {
  fallback_file1 = true,
}

require("git"):setup()

require("full-border"):setup()

require("mactag"):setup {
  keys = {
    r = "Red",
    o = "Orange",
    y = "Yellow",
    g = "Green",
    b = "Blue",
    p = "Purple",
  },
  colors = {
    Red = "#ee7b70",
    Orange = "#f5bd5c",
    Yellow = "#fbe764",
    Green = "#91fc87",
    Blue = "#5fa3f8",
    Purple = "#cb88f8",
  },
}
