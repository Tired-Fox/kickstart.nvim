local M = {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
}

M.config = function()
  local wk = require 'which-key'
  local tc = require 'todo-comments'

  tc.setup {
    keywords = {
      FIX = {
        icon = " ", -- icon used for the sign, and in search results
        color = "error", -- can be a hex color, or a named color (see below)
        alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
        -- signs = false, -- configure signs for some keywords individually
      },
      TODO = { icon = " ", color = "info" },
      HACK = { icon = " ", color = "warning" },
      WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
      PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
      NOTE = { icon = "󰌶 ", color = "hint", alt = { "INFO" } },
      TEST = { icon = "", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
    },
  }
  
  wk.register {
    [']t'] = { function() tc.jump_next {keywords={'TODO', 'FIX', 'TEST'}} end, 'Next Comment' },
    ['[t'] = { function() tc.jump_prev {keywords={'TODO', 'FIX', 'TEST'}} end, 'Previous Comment' },
    ['<leader>ft'] = {  '<cmd>TodoTelescope<cr>', 'Previous Comment' },
  }
end

return M
