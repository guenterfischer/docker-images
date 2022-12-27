-- ~/.config/nvim/lua/remap.lua

vim.g.mapleader = " "

-- Window handling
vim.keymap.set("n", "<leader>wn", "<C-w><C-w>")
vim.keymap.set("n", "<leader>wd", ":bdelete<CR>")
vim.keymap.set("n", "<leader>wh", "<C-w>h")
vim.keymap.set("n", "<leader>wj", "<C-w>j")
vim.keymap.set("n", "<leader>wk", "<C-w>k")
vim.keymap.set("n", "<leader>wl", "<C-w>l")

-- Buffer handling
vim.keymap.set("n", "<leader>bn", ":bnext<CR>")
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>")
vim.keymap.set("n", "<leader>bd", ":bprevious <BAR> bdelete #<CR>")

-- Diff
vim.keymap.set("n", "<leader>dt", ":diffthis<CR>")
vim.keymap.set("n", "<leader>do", ":diffoff<CR>")
vim.keymap.set("n", "<leader>dg", ":diffget<CR>")
vim.keymap.set("n", "<leader>dp", ":diffput<CR>")

-- NERDTree
vim.keymap.set("n", "<leader>no", ":NERDTreeFocus<CR>")
vim.keymap.set("n", "<leader>nf", ":NERDTreeFind<CR>")
vim.keymap.set("n", "<leader>nt", ":NERDTreeToggle<CR>")

-- Git
vim.keymap.set("n", "<leader>gn", ":GitGutterNextHunk<CR>")
vim.keymap.set("n", "<leader>gp", ":GitGutterPrevHunk<CR>")
vim.keymap.set("n", "<leader>gd", ":GitGutterPreviewHunk<CR>")
vim.keymap.set("n", "<leader>gs", ":GitGutterStageHunk<CR>")
vim.keymap.set("n", "<leader>gu", ":GitGutterUndoHunk<CR>")
