local M = {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
}

M.config = function()
  require('catppuccin').setup({
    flavour = "mocha",
    background = {
      dark = "mocha",
      light = "latte",
    },
    integrations = {
      navic = {
        enabled = true,
      },
      cmp = true,
      gitsigns = true,
      treesitter = true
    }
  })
  vim.cmd("colorscheme catppuccin")
end

return M
