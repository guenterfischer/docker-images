-- ~/.config/nvim/after/plugin/tree.lua

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
  open_on_setup = true,
  renderer = {
    icons = {
      webdev_colors = false,
      git_placement = "after",
      padding = "  ",
      show = {
        file = false,
        folder = true,
        folder_arrow = true,
        git = true,
        modified = true
      }
    },
    special_files = {}
  }
})

vim.keymap.set("n", "<leader>to", ":NvimTreeFocus<CR>")
vim.keymap.set("n", "<leader>tf", ":NvimTreeFindFile<CR>")
vim.keymap.set("n", "<leader>tt", ":NvimTreeToggle<CR>")
