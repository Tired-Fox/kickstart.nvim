local M = {
  'j-morano/buffer_manager.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim'
  }
}

M.config = function()
  local wk = require 'which-key'
  local bufman = require 'buffer_manager'
  local ui = require 'buffer_manager.ui'

  bufman.setup {
    select_menu_item_commands = {
      v = {
        key = "<C-v>",
        command = "vsplit"
      },
      h = {
        key = "<C-h>",
        command = "split"
      }
    },
  }

  wk.register {
    [']b'] = { ui.nav_next, "" },
    ['[b'] = { ui.nav_prev, "" },
  }
end

return M
