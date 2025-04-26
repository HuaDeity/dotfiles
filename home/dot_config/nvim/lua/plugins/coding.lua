return {
  {
    "saghen/blink.cmp",
    optional = true,
    dependencies = { "milanglacier/minuet-ai.nvim" },
    opts = {
      keymap = {
        ["<A-y>"] = {
          function(cmp)
            cmp.show({ providers = { "minuet" } })
          end,
        },
      },
      sources = {
        default = { "minuet" },
        providers = {
          minuet = {
            name = "minuet",
            module = "minuet.blink",
            async = true,
            -- Should match minuet.config.request_timeout * 1000,
            -- since minuet.config.request_timeout is in seconds
            timeout_ms = 3000,
            score_offset = 100, -- Gives minuet higher priority among suggestions
          },
          path = {
            opts = {
              show_hidden_files_by_default = true,
            },
          },
        },
      },
      -- Recommended to avoid unnecessary request
      completion = { trigger = { prefetch_on_insert = false } },
    },
  },
}
