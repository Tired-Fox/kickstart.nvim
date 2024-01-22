local dap, dapui = require('dap'), require('dapui')

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
