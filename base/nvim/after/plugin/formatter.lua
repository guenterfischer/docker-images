-- ~/.config/nvim/after/plugin/formatter.lua
--
-- Utilities for creating configurations
local util = require "formatter.util"

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require("formatter").setup {
  -- Enable or disable logging
  logging = true,
  -- Set the log level
  log_level = vim.log.levels.WARN,
  -- All formatter configurations are opt-in
  filetype = {
    python = {
      require("formatter.filetypes.python").autopep8,
    },

    ruby = {
      require("formatter.filetypes.ruby").rubocop,
    },

    sh = {
      require("formatter.filetypes.sh").shfmt,
    },

    json = {
      require("formatter.filetypes.json").prettier,
    },

    yaml = {
      require("formatter.filetypes.yaml").pyaml,
    },

    c = {
      require("formatter.filetypes.c").clangformat,
    },

    cpp = {
      require("formatter.filetypes.cpp").clangformat,
    },

    cmake = {
      require("formatter.filetypes.cmake").cmakeformat,
    },

    javascript = {
      require("formatter.filetypes.javascript").prettier,
    },

    typescriptreact = {
      require("formatter.filetypes.typescriptreact").prettier,
    },

    typescript = {
      require("formatter.filetypes.typescript").prettier,
    },

    javascriptreact = {
      require("formatter.filetypes.javascriptreact").prettier,
    },

    ["*"] = {
      require("formatter.filetypes.any").remove_trailing_whitespace
    }
  }
}

-- Format on save
vim.api.nvim_create_augroup("FormatAutogroup", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
    group = "FormatAutogroup",
    command = "FormatWrite",
})
