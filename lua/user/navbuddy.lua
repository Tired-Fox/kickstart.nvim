local M = {
  'SmiteshP/nvim-navbuddy',
  dependencies = {
    'neovim/nvim-lspconfig',
    'navic',
    'MunifTanjim/nui.nvim',
    -- Optional
    'numToStr/Comment.nvim',
    'nvim-telescope/telescope.nvim'
  },
  opts = {
    window = {
      border = 'rounded',
      size = '90%'
    }
  }
}

return M
