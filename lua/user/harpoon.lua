-- TODO: Update to 'harpoon2' when known how to use it
local M = {
  'ThePrimeagen/harpoon',
}

M.config = function()
  local wk = require 'which-key'
  local ui = require 'harpoon.ui'
  local mark = require 'harpoon.mark'

  wk.register {
    ["<leader>."] = { ui.toggle_quick_menu, "[.] Harpoon" },
    ["<leader>ha"] = { mark.add_file, "Add File" },
    ["<A-1>"] = { function() ui.nav_file(1) end, "Goto 1" },
    ["<A-2>"] = { function() ui.nav_file(2) end, "Goto 2" },
    ["<A-3>"] = { function() ui.nav_file(3) end, "Goto 3" },
    ["<A-4>"] = { function() ui.nav_file(4) end, "Goto 4" },
  }
end

return M
