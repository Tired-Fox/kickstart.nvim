local M = {
  "folke/which-key.nvim",
  event = "VeryLazy",
}

M.config = function()
  local mappings = {
    Q = { "<cmd>qall<CR>", "Quit" },
    c = { "<cmd>bdelete!<CR>", "Close" },
    h = { "<cmd>nohlsearch<CR>", "NOHL" },
    b = { name = "Buffers" },
    d = { name = "Debug" },
    f = { name = "Find" },
    g = { name = "Git" },
    l = { name = "LSP" },
    p = { name = "Plugins" },
  }

  local which_key = require "which-key"
  which_key.setup {
    hidden = { '<space>' },
    plugins = {
      marks = true,
      registers = true,
      spelling = {
        enabled = true,
        suggestions = 20,
      },
      presets = {
        operators = false,
        motions = false,
        text_objects = false,
        windows = false,
        nav = false,
        z = false,
        g = false,
      },
    },
    window = {
      border = "rounded",
      position = "bottom",
      padding = { 2, 2, 2, 2 },
    },
    ignore_missing = true,
    show_help = false,
    show_keys = false,
    disable = {
      buftypes = {},
      filetypes = { "TelescopePrompt" },
    },
  }

  local opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
  }

  which_key.register(mappings, opts)
end

return M
