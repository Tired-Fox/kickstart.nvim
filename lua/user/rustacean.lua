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
        if client.server_capabilities.documentSymbolProvider then
          require('nvim-navic').attach(client, bufnr)
          vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
        end
        require('nvim-navbuddy').attach(client, bufnr)

        -- TODO: Add mappings
        local wk = require 'which-key'
        wk.register {
          ['<leader>la'] = { function() vim.cmd.RustLsp('codeAction') end, 'Code Action' },
          ['K'] = { function() vim.cmd.RustLsp('hover', 'actions') end, 'Hover Actions' },
          ['<leader>lr'] = { vim.lsp.buf.rename, 'Rename' },
          ['gd'] = { require('telescope.builtin').lsp_definitions, 'Goto Definition' },
          ['gr'] = { require('telescope.builtin').lsp_references, 'Goto References' },
          ['gI'] = { require('telescope.builtin').lsp_implementations, 'Goto Implementation' },
          ['<leader>lD'] = { require('telescope.builtin').lsp_type_definitions, 'Type Definition' },
          ['<leader>ls'] = { require('telescope.builtin').lsp_document_symbols, 'Document Symbols' },
          ['<leader>lS'] = { require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace Symbols' },
          -- See `:help K` for why this keymap
          ['<C-k>'] = { vim.lsp.buf.signature_help, 'Signature Documentation' },
          ['gD'] = { vim.lsp.buf.declaration, 'Goto Declaration' },
        }
      end,
    },
    dap = {
      adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path)
    },
  }
end

return M
