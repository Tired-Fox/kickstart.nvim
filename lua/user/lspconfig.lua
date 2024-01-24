local M = {
  -- LSP Configuration & Plugins
  'neovim/nvim-lspconfig',
  dependencies = {
    -- Automatically install LSPs to stdpath for neovim
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',

    -- Useful status updates for LSP
    -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
    { 'j-hui/fidget.nvim', opts = {} },

    -- Additional lua configuration, makes nvim stuff amazing!
    'folke/neodev.nvim',
  },
}

-- Change diagnostic symbols
local signs = { Error = "", Warn = "", Hint = "󰌶", Info = "" }
for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- Turn off virtual text diagnostic
vim.diagnostic.config {
  virtual_text = false,
  underline = true,
  float = {
    border = 'rounded'
  }
}

local servers = {
  -- clangd = {},
  zls = {},
  gopls = {},
  pyright = {},
  -- tsserver = {},
  -- html = { filetypes = { 'html', 'twig', 'hbs'} },
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      -- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
      diagnostics = { disable = { 'missing-fields' } },
    },
  },
}

local border = 'rounded'
local handlers = {
  ['textDocument/hover'] = vim.lsp.with(
    vim.lsp.handlers.hover,
    { border = border }
  ),
  ['textDocument/signatureHelp'] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    { border = border }
  ),
}

M.keybinds = function(wk)
  wk.register {
    ['<leader>lr'] = { vim.lsp.buf.rename, 'Rename' },
    ['<leader>la'] = { vim.lsp.buf.code_action, 'Code Action' },
    ['gd'] = { require('telescope.builtin').lsp_definitions, 'Goto Definition' },
    ['gr'] = { require('telescope.builtin').lsp_references, 'Goto References' },
    ['gI'] = { require('telescope.builtin').lsp_implementations, 'Goto Implementation' },
    ['<leader>lD'] = { require('telescope.builtin').lsp_type_definitions, 'Type Definition' },
    ['<leader>ls'] = { require('telescope.builtin').lsp_document_symbols, 'Document Symbols' },
    ['<leader>lS'] = { require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace Symbols' },
    -- See `:help K` for why this keymap
    ['K'] = { vim.lsp.buf.hover, 'Hover Documentation' },
    ['<C-k>'] = { vim.lsp.buf.signature_help, 'Signature Documentation' },
    ['gD'] = { vim.lsp.buf.declaration, 'Goto Declaration' },
    -- ['<leader>wa'] = { vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder' },
    -- ['<leader>wr'] = { vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder' },
    -- Lesser used LSP functionality
    -- ['<leader>wl'] = { function()
    --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    -- end, '[W]orkspace [L]ist Folders' },
  }
end

M.attach_navic = function(client, bufnr)
  if client.server_capabilities.documentSymbolProvider then
    require('nvim-navic').attach(client, bufnr)
    vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
  end
  require('nvim-navbuddy').attach(client, bufnr)
end

local on_attach = function(client, bufnr)
  local wk = require 'which-key'
  M.keybinds(wk)
  M.attach_navic(client, bufnr)

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

M.config = function()
  local mason_lspconfig = require('mason-lspconfig')
  require('mason').setup()
  mason_lspconfig.setup()
  require('mason-nvim-dap').setup({
    ensure_installed = { 'codelldb' }
  })

  -- Setup neovim lua configuration
  require('neodev').setup()
  --
  -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

  -- Ensure the servers above are installed

  mason_lspconfig.setup {
    ensure_installed = vim.tbl_keys(servers),
  }

  mason_lspconfig.setup_handlers {
    function(server_name)
      if server_name == 'rust_analyzer' then
        return
      end

      require('lspconfig')[server_name].setup {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = servers[server_name],
        filetypes = (servers[server_name] or {}).filetypes,
        handlers = handlers
      }
    end,
  }
end

return M
