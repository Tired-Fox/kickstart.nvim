local M = {
  'Saecki/crates.nvim',
  tag = 'stable',
  event = { 'BufRead Cargo.toml' },
  config = function()
    require('crates').setup()
  end
}

return M
