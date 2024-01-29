-- https://github.com/stevearc/conform.nvim

local M = {
  'stevearc/conform.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
}

M.slow_format_filetypes = {}
local formatters_by_ft = {
  lua = { 'stylua' },
  python = function(bufnr)
    if require('conform').get_formatter_info('ruff_format', bufnr).available then
      return { 'ruff_format' }
    else
      return { 'isort', 'black' }
    end
  end,
  toml = { 'taplo' },
  zig = { 'zigfmt' },
  javascript = { 'prettier' },
  typescript = { 'prettier' },
  javascriptreact = { 'prettier' },
  typescriptreact = { 'prettier' },
  svelte = { 'prettier' },
  css = { 'prettier' },
  html = { 'prettier' },
  json = { 'prettier' },
  yaml = { 'prettier' },
  markdown = { 'prettier' },
}
local formatters = {}

M.config = function()
  local conform = require 'conform'

  conform.setup {
    formatters_by_ft = vim.tbl_keys(formatters_by_ft),
    formatters = vim.tbl_keys(formatters),
    format_on_save = function(bufnr)
      -- Disable with a global or buffer-local variable
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end

      if M.slow_format_filetypes[vim.bo[bufnr].filetype] then
        return
      end

      local function on_format(err)
        if err and err:match 'timeout$' then
          M.slow_format_filetypes[vim.bo[bufnr].filetype] = true
        end
      end

      return { timeout_ms = 500, lsp_fallback = true }, on_format
    end,
    format_after_save = function(bufnr)
      if not M.slow_format_filetypes[vim.bo[bufnr].filetype] then
        return
      end
      return { lsp_fallback = true }
    end,
  }

  -- Create a command `:Format` to format the current buffer
  vim.api.nvim_create_user_command('Format', function(_)
    conform.format {
      -- If formatter not specified then use `vim.lsp.buf.format()`
      lsp_fallback = true,
    }
  end, { desc = 'Format current buffer with Conform' })

  vim.api.nvim_create_user_command('FormatDisable', function(args)
    if args.bang then
      -- FormatDisable! will disable formatting just for this buffer
      vim.b.disable_autoformat = true
    else
      vim.g.disable_autoformat = true
    end
  end, {
    desc = 'Disable autoformat-on-save',
    bang = true,
  })
  vim.api.nvim_create_user_command('FormatEnable', function()
    vim.b.disable_autoformat = false
    vim.g.disable_autoformat = false
  end, {
    desc = 'Re-enable autoformat-on-save',
  })
end

return M
