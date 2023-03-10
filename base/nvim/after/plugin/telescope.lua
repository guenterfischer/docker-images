-- ~/.config/nvim/after/plugin/telescope.lua

local builtin = require('telescope.builtin')

vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fk", builtin.keymaps, {})
vim.keymap.set("n", "<leader>fr", builtin.lsp_references, {})
