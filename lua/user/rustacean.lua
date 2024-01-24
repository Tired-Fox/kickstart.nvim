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
    on_attach = function(client, bufnr)
      if client.server_capabilities.documentSymbolProvider then
        require('nvim-navic').attach(client, bufnr)
        vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
      end
      require('nvim-navbuddy').attach(client, bufnr)

      -- TODO: Add mappings
      local wk = require 'which-key'
      wk.register {
        ['<leader>la'] = { function() vim.cmd.RustLsp('codeAction') end, 'Code Action' },
        ['<S-k>'] = { function() vim.cmd.RustLsp('hover', 'actions') end, 'Code Action' },
      }
    end,
    server = {
      settings = {
        ['rust-analyzer'] = {
          checkOnSave = {
            command = 'clippy'
          }
        }
      }
    },
    dap = {
      adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path)
    },
  }
end

return M
