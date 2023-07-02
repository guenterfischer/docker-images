-- ~/.config/nvim/after/plugin/lsp.lua

local lsp = require('lsp-zero')

lsp.preset('recommended')

-- Hint: List all available servers with ':help lspconfig-all'
lsp.ensure_installed({
  'bashls',
  'clangd',
  'cmake',
  'cssls',
  'dockerls',
  'eslint',
  'html',
  'jsonls',
  'lua_ls',
  'pylsp',
  'solargraph',
  'tsserver',
  'yamlls'
})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['C-p'] = cmp.mapping.select_prev_item(cmp_select),
  ['C-n'] = cmp.mapping.select_next_item(cmp_select),
  ['<CR>'] = cmp.mapping.confirm({ select = true }),
})

lsp.setup_nvim_cmp({
  mapping = cmp_mappings,
  completion =  { autocomplete = false }
})

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

lsp.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}

  vim.keymap.set("n", "<leader>go", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "<leader>lh", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<leader>sym", vim.lsp.buf.workspace_symbol, opts)
  vim.keymap.set("n", "<leader>lo", vim.diagnostic.open_float, opts)
  vim.keymap.set("n", "<leader>ln", vim.diagnostic.goto_next, opts)
  vim.keymap.set("n", "<leader>lp", vim.diagnostic.goto_prev, opts)
  vim.keymap.set("n", "<leader>fix", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>ref", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "<leader>ren", vim.lsp.buf.rename, opts)
end)

lsp.setup()

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = true,
})
