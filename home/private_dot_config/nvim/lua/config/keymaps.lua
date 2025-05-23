-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- better up/down
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- Resize window using <ctrl> arrow keys
vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Move Lines
vim.keymap.set("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
vim.keymap.set("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
vim.keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
vim.keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
vim.keymap.set("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
vim.keymap.set("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

-- buffers
-- vim.keymap.set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
-- vim.keymap.set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
-- vim.keymap.set("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
-- vim.keymap.set("n", "]b", "<cmd>bnext<cr>", { desc = "Next Buffer" })
vim.keymap.set("n", "<C-6>", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
vim.keymap.set("n", "<C-^>", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
vim.keymap.set("n", "<S-z>Z", function() Snacks.bufdelete() end, { desc = "Delete Buffer" })
vim.keymap.set("n", "<S-z>Q", function() Snacks.bufdelete { force = true } end, { desc = "Delete Buffer(Force)" })
vim.keymap.set("n", "<S-z>A", function() Snacks.bufdelete.other() end, { desc = "Delete Other Buffers" })
vim.keymap.set("n", "<S-z>D", "<cmd>:bd<cr>", { desc = "Delete Buffer and Window" })

-- Clear search and stop snippet on escape
vim.keymap.set({ "i", "n", "s" }, "<esc>", function()
  vim.cmd "noh"
  if vim.snippet then vim.snippet.stop() end
  return "<esc>"
end, { expr = true, desc = "Escape and Clear hlsearch" })

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
vim.keymap.set(
  "n",
  "<leader>ur",
  "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "Redraw / Clear hlsearch / Diff Update" }
)

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
vim.keymap.set("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
vim.keymap.set("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
vim.keymap.set("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
vim.keymap.set("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
vim.keymap.set("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
vim.keymap.set("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

-- Add undo break-points
vim.keymap.set("i", ",", ",<c-g>u")
vim.keymap.set("i", ".", ".<c-g>u")
vim.keymap.set("i", ";", ";<c-g>u")

-- save file
vim.keymap.set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

--keywordprg
vim.keymap.set("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "Keywordprg" })

-- better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- commenting
vim.keymap.set("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
vim.keymap.set("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })

-- lazy
vim.keymap.set("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- new file
vim.keymap.set("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

-- location list
vim.keymap.set("n", "<leader>xl", function()
  local success, err = pcall(vim.fn.getloclist(0, { winid = 0 }).winid ~= 0 and vim.cmd.lclose or vim.cmd.lopen)
  if not success and err then vim.notify(err, vim.log.levels.ERROR) end
end, { desc = "Location List" })

-- quickfix list
vim.keymap.set("n", "<leader>xq", function()
  local success, err = pcall(vim.fn.getqflist({ winid = 0 }).winid ~= 0 and vim.cmd.cclose or vim.cmd.copen)
  if not success and err then vim.notify(err, vim.log.levels.ERROR) end
end, { desc = "Quickfix List" })

vim.keymap.set("n", "[q", vim.cmd.cprev, { desc = "Previous Quickfix" })
vim.keymap.set("n", "]q", vim.cmd.cnext, { desc = "Next Quickfix" })

-- diagnostic
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function() go { severity = severity } end
end
-- vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
vim.keymap.set("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
vim.keymap.set("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
vim.keymap.set("n", "g}", diagnostic_goto(true), { desc = "Next Diagnostic" })
vim.keymap.set("n", "g{", diagnostic_goto(false), { desc = "Prev Diagnostic" })
vim.keymap.set("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
vim.keymap.set("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
vim.keymap.set("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
vim.keymap.set("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

-- toggle options
-- Keep the same Snacks toggle implementation
Snacks.toggle.option("spell", { name = "Spelling" }):map "<leader>us"
Snacks.toggle.option("wrap", { name = "Wrap" }):map "<leader>uw"
Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map "<leader>uL"
Snacks.toggle.diagnostics():map "<leader>ud"
Snacks.toggle.line_number():map "<leader>ul"
Snacks.toggle
  .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2, name = "Conceal Level" })
  :map "<leader>uc"
Snacks.toggle
  .option("showtabline", { off = 0, on = vim.o.showtabline > 0 and vim.o.showtabline or 2, name = "Tabline" })
  :map "<leader>uA"
Snacks.toggle.treesitter():map "<leader>uT"
Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map "<leader>ub"
Snacks.toggle.dim():map "<leader>uD"
Snacks.toggle.animate():map "<leader>ua"
Snacks.toggle.indent():map "<leader>ug"
Snacks.toggle.scroll():map "<leader>uS"
Snacks.toggle.profiler():map "<leader>dpp"
Snacks.toggle.profiler_highlights():map "<leader>dph"

if vim.lsp.inlay_hint then Snacks.toggle.inlay_hints():map "<leader>uh" end

-- lazygit
if vim.fn.executable "lazygit" == 1 then
  vim.keymap.set(
    "n",
    "<leader>gg",
    function() Snacks.lazygit { cwd = ViM.root.git() } end,
    { desc = "Lazygit (Root Dir)" }
  )
  vim.keymap.set("n", "<leader>gG", function() Snacks.lazygit() end, { desc = "Lazygit (cwd)" })
  vim.keymap.set("n", "<leader>gf", function() Snacks.picker.git_log_file() end, { desc = "Git Current File History" })
  vim.keymap.set("n", "<leader>gl", function() Snacks.picker.git_log { cwd = ViM.root.git() } end, { desc = "Git Log" })
  vim.keymap.set("n", "<leader>gL", function() Snacks.picker.git_log() end, { desc = "Git Log (cwd)" })
end

vim.keymap.set("n", "<leader>gb", function() Snacks.picker.git_log_line() end, { desc = "Git Blame Line" })
vim.keymap.set({ "n", "x" }, "<leader>gB", function() Snacks.gitbrowse() end, { desc = "Git Browse (open)" })
vim.keymap.set({ "n", "x" }, "<leader>gY", function()
  Snacks.gitbrowse { open = function(url) vim.fn.setreg("+", url) end, notify = false }
end, { desc = "Git Browse (copy)" })

-- quit
vim.keymap.set("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })

-- highlights under cursor
vim.keymap.set("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })
vim.keymap.set("n", "<leader>uI", function()
  vim.treesitter.inspect_tree()
  vim.api.nvim_input "I"
end, { desc = "Inspect Tree" })

-- floating terminal
vim.keymap.set("n", "<leader>fT", function() Snacks.terminal() end, { desc = "Terminal (cwd)" })
vim.keymap.set(
  "n",
  "<leader>ft",
  function() Snacks.terminal(nil, { cwd = ViM.root() }) end,
  { desc = "Terminal (Root Dir)" }
)
vim.keymap.set(
  "n",
  "<c-/>",
  function() Snacks.terminal(nil, { cwd = ViM.root() }) end,
  { desc = "Terminal (Root Dir)" }
)
vim.keymap.set("n", "<c-_>", function() Snacks.terminal(nil, { cwd = ViM.root() }) end, { desc = "which_key_ignore" })

-- Terminal Mappings
vim.keymap.set("t", "<C-/>", "<cmd>close<cr>", { desc = "Hide Terminal" })
vim.keymap.set("t", "<c-_>", "<cmd>close<cr>", { desc = "which_key_ignore" })

-- windows
vim.keymap.set("n", "<leader>-", "<C-W>s", { desc = "Split Window Below", remap = true })
vim.keymap.set("n", "<leader>|", "<C-W>v", { desc = "Split Window Right", remap = true })
vim.keymap.set("n", "<leader>wd", "<C-W>c", { desc = "Delete Window", remap = true })
Snacks.toggle.zoom():map("<leader>wm"):map "<leader>uZ"
Snacks.toggle.zen():map "<leader>uz"

-- tabs
vim.keymap.set("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
vim.keymap.set("n", "<leader><tab>o", "<cmd>tabonly<cr>", { desc = "Close Other Tabs" })
vim.keymap.set("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
vim.keymap.set("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
vim.keymap.set("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
vim.keymap.set("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
vim.keymap.set("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

vim.keymap.set({ "n", "i", "v", "x" }, "<D-c>", '"+y', { desc = "MacOS copy" })
