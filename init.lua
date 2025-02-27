--[[
==================================
        Tired Fox Config
==================================
--]]

require 'user.launch'
require 'user.options'
require 'user.keymaps'
require 'user.autocmds'

spec 'user.theme'
spec 'user.whichkey'
spec 'user.lualine'
spec 'user.treesitter'
spec 'user.lspconfig'
spec 'user.cmp'

-- conform = formatting
spec 'user.conform'
-- nvim-lint = linting
spec 'user.lint'

spec 'user.telescope'
spec 'user.autopairs'
spec 'user.dap'
spec 'user.codeium'
spec 'user.comment'
spec 'user.git'
spec 'user.indent-blankline'
spec 'user.navbuddy'
spec 'user.navic'
spec 'user.oil'
spec 'user.sleuth'
spec 'user.buffer_manager'
spec 'user.harpoon'
spec 'user.todo-comment'
spec 'user.pqf'
spec 'user.bqf'
spec 'user.fzf'
spec 'user.neogit'

-- Rust
spec 'user.rustacean'
spec 'user.crates'

require 'user.powershell'
require 'user.lazy'
