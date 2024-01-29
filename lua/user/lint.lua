local M = {
  'mfussenegger/nvim-lint',
  event = {
    'BufReadPre',
    'BufNewFile',
  }
}

M.config = function()
  local lint = require('lint')

  lint.linters_by_ft = {
    python = { 'ruff' },
    javascirpt = { 'eslint_d' },
    typescript = { 'eslint_d' },
    javascirptreact = { 'eslint_d' },
    typescriptreact = { 'eslint_d' },
    svelte = { 'eslint_d' },
  }

  local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
  vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
    group = lint_augroup,
    callback = function()
      lint.try_lint()
    end
  })

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_create_user_command('Lint', function(_)
    lint.try_lint()
  end, { desc = 'Lint current buffer with nvim-lint' })
end

return M
