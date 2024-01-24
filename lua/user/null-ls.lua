local M = {
  'nvimtools/none-ls.nvim'
}

M.config = function()
  local null_ls = require 'null-ls'

  local formatting = null_ls.builtins.formatting

  null_ls.setup {
    debug = true,
    sources = {
      formatting.stylua,
      formatting.prettier,
      formatting.black,
      null_ls.builtins.completion.spell
    }
  }
end

return M
