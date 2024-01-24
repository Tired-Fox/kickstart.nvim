local M = {
  'mfussenegger/nvim-dap',
  name = 'dap',
  dependencies = {
    'jay-babu/mason-nvim-dap.nvim',
    'rcarriga/nvim-dap-ui',
    {
      'nvim-telescope/telescope-dap.nvim',
      dependencies = { 'telescope' }
    },
  }
}

M.config = function()
  local dap, dapui = require('dap'), require('dapui')
  dapui.setup()
  local wk = require 'which-key'

  local dap_round_groups = { "DapBreakpoint", "DapBreakpointCondition", "DapBreakpointRejected", "DapLogPoint" }
  for _, group in pairs(dap_round_groups) do
    vim.fn.sign_define(group, { text = "●", texthl = group })
  end

  vim.api.nvim_create_user_command('DapClose', function(_)
    require('dapui').close()
  end, { desc = 'Close DAP UI' })

  -- Use dap hooks to open and close dap ui
  dap.listeners.before.attach.dapui_config = function()
    dapui.open()
  end
  dap.listeners.before.launch.dapui_config = function()
    dapui.open()
  end
  -- dap.listeners.before.event_terminated.dapui_config = function()
  --   dapui.close()
  -- end
  -- dap.listeners.before.event_exited.dapui_config = function()
  --   dapui.close()
  -- end

  wk.register {
    ['<leader>db'] = { function() dap.toggle_breakpoint() end, 'Toggle Breakpoint'},
    ['<leader>dc'] = { function() dapui.close() end, 'DAP UI Close'},
    ['<F9>'] = { function() dap.continue() end, 'DAP UI Close'},
    ['<F8>'] = { function() dap.step_over() end, 'DAP UI Close'},
    ['<F7>'] = { function() dap.step_into() end, 'DAP UI Close'},
    ['<S-F8>'] = { function() dap.step_out() end, 'DAP UI Close'},
  }
end

return M
