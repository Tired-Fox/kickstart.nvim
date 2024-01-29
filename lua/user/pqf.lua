local M = {
  'yorickpeterse/nvim-pqf'
}

M.config = function()
  local pqf = require 'pqf'
  pqf.setup()
end

return M
