-- [[ Configure options ]]
local configuration = {
  opt = {
    -- For better Neorg experience
    foldlevelstart = 99,
    conceallevel = 3,
    -- Alwasy use spaces for tabs
    expandtab = true,
    -- Set tab look
    tabstop = 4,
    shiftwidth = 4,
    -- set number line width {defaults to 4}
    numberwidth = 3,
    backup = false,
    undofile = true, -- enable persistent undo
    swapfile = false,
    writebackup = false,
  },
  o = {
    cmdheight=1,
    -- Set highlight on search
    hlsearch = false,
    -- Enable mouse mode
    mouse = 'a',
    relativenumber = true,
    -- Sync clipboard between OS and Neovim.
    --  Remove this option if you want your OS clipboard to remain independent.
    --  See `:help 'clipboard'`
    clipboard = 'unnamedplus',
    -- Enable break indent
    breakindent = true,
    -- Save undo history
    undofile = true,
    -- Case-insensitive searching UNLESS \C or capital in search
    ignorecase = true,
    smartcase = true,
    -- Decrease update time
    updatetime = 250,
    timeout = true,
    timeoutlen = 300,
    -- Set completeopt to have a better completion experience
    completeopt = 'menuone,noselect',
    -- NOTE: You should make sure your terminal supports this
    termguicolors = true,
  },
  wo = {
    -- Make line numbers default
    number = true,
    -- Keep signcolumn on by default
    signcolumn = 'yes',
  }
}

vim.cmd("set fileformats+=unix")

-- [[ Set options ]]
-- Options are automatically built
for category, cvalue in pairs(configuration) do
  -- This outer iteration is the opt, o, and wo which equals vim.opt, etc...
  for option, value in pairs(cvalue) do
    -- This inner iteration is each option per option
    vim[category][option] = value
  end
end
