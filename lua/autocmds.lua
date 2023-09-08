-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

local bool = function(int) return int ~= 0 end

local mkdir_group = vim.api.nvim_create_augroup('AutoMkdir', { clear = true })
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  callback = function()
    local dir = vim.fn.expand('%:p:h')
    if not bool(vim.fn.isdirectory(dir)) and (
          bool(vim.v.cmdbang)
          or string.match(vim.fn.input("'" .. dir .. "' does not exist. Create? [y/N] "), "[yY]")
        ) then
      vim.fn.mkdir(dir, 'p')
    end
  end,
  group = mkdir_group,
  pattern = '*.*',
})

local set_wrap = vim.api.nvim_create_augroup('SetWrap', { clear = true })
vim.api.nvim_create_autocmd({ "BufRead" }, {
  callback = function()
    vim.cmd [[ set nowrap ]]
  end,
  group = set_wrap,
  pattern = "*.norg"
})
