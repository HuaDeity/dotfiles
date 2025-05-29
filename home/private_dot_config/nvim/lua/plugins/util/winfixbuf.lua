return {
  {
    "stevearc/stickybuf.nvim",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    cmd = { "PinBuffer", "PinBuftype", "PinFiletype" },
    opts = {},
  },
}
