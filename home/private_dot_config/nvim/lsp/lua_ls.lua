return {
  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace",
      },
      -- workspace = {
      --   checkThirdParty = false,
      -- },
      codeLens = {
        enable = true,
      },
      doc = {
        privateName = { "^_" },
      },
      hint = {
        enable = true,
        setType = false,
        paramType = true,
        paramName = "Disable",
        semicolon = "Disable",
        arrayIndex = "Disable",
      },
    },
  },
}
