return {
  {
    'mfussenegger/nvim-dap',
    name = 'dap',
    dependencies = {
      'jay-babu/mason-nvim-dap.nvim',
    }
  },
  {
      'rcarriga/nvim-dap-ui',
      opts={},
      dependencies = {
        'dap'
      }
  },
  {
    'nvim-telescope/telescope-dap.nvim',
    dependencies = {
      'dap',
      'telescope',
    }
  }
}
