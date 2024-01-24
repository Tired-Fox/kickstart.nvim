local M = {
  'mrcjkb/rustaceanvim',
  ft = { 'rust' },
}

M.init = function()
  local extension_path = vim.fn.stdpath('data') .. '/mason/packages/codelldb/extension/'
  local codelldb_path = extension_path .. 'adapter/codelldb'
  local liblldb_path = extension_path .. 'lldb/lib/liblldb'
  local this_os = vim.loop.os_uname().sysname;

  if this_os:find "Windows" then
    codelldb_path = extension_path .. 'adapter\\codelldb.exe'
    liblldb_path = extension_path .. 'lldb\\bin\\liblldb.dll'
  else
    liblldb_path = liblldb_path .. (this_os == "Linux" and ".so" or ".dylib")
  end

  local cfg = require('rustaceanvim.config')
  vim.g.rustaceanvim = {
    tools = {
      hover_actions = {
        auto_focus = true
      },
      -- ref: api-win_config
      float_win_config = {}
    },
    server = {
      settings = {
        ['rust-analyzer'] = {
          checkOnSave = {
            command = 'clippy'
          }
        }
      },
      on_attach = function(client, bufnr)
        local lspconfig = require 'user.lspconfig'
        lspconfig.attach_navic(client, bufnr)

        local wk = require 'which-key'
        lspconfig.keybinds(wk)
        wk.register {
          ['<leader>la'] = { function() vim.cmd.RustLsp('codeAction') end, 'Code Action' },
          ['K'] = { function() vim.cmd.RustLsp('hover', 'actions') end, 'Hover Actions' },
        }
      end,
    },
    dap = {
      adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path)
    },
  }
end

return M
