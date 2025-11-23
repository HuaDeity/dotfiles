return {
  settings = {
    gopls = {
      gofumpt = true,
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        -- ignoredError = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
      usePlaceholders = true,
      semanticTokens = true,
    },
  },
}
