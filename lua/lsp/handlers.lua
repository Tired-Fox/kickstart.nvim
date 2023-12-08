local M = {}

-- TODO: backfill this to template

local function lsp_highlight_document(client)
  -- Set autocommands conditional on server_capabilities
  if client.server_capabilities.documentHighlight then
    vim.api.nvim_exec(
      [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
      false
    )
  end
end

-- TODO: Navic
-- local function lsp_attach_navic(client, bufnr, navic)
--   if client.server_capabilities.documentSymbolProvider then
--     navic.attach(client, bufnr)
--     vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
--   end
-- end

local function opts (desc)
  return { noremap = true, silent = true, desc = desc }
end

local function lsp_keymaps(bufnr)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts("lsp declaration"))
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts("lsp definition"))
  vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts("lsp hover"))
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts("lsp implplementation"))
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts("lsp signature help"))
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>dr", "<cmd>lua vim.lsp.buf.rename()<CR>", opts("lsp rename"))
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts("lsp references"))
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>f", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts("prev diagnostic"))
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "gl",
    '<cmd>lua vim.diagnostic.open_float()<CR>',
    opts("open diagnostic float")
  )
  vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts("next diagnostic"))
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>dq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
  -- vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.format { async = true }' ]]
end

M.on_attach = function(client, bufnr)
  if client.name == "tsserver" then
    client.server_capabilities.documentFormattingProvider = false
  end

  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  lsp_keymaps(bufnr)
  lsp_highlight_document(client)
  local status_ok, navic = pcall(require, 'nvim-navic')
  if status_ok then
    lsp_attach_navic(client, bufnr, navic)
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
  return
end

M.capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

return M
