vim.keymap.set("n", "<S-z>Z", function() require("snacks").bufdelete() end, { desc = "Delete Buffer" })
vim.keymap.set(
  "n",
  "<S-z>Q",
  function() require("snacks").bufdelete { force = true } end,
  { desc = "Delete Buffer(Force)" }
)
vim.keymap.set("n", "<S-z>A", function() require("snacks").bufdelete.other() end, { desc = "Delete Other Buffers" })
