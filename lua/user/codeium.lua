local enabled = true 

local M = {
  "Exafunction/codeium.nvim",
  enabled = enabled,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
  },
}

M.config = function()
  -- Change this for different default enabled state
  vim.g.codeium_enabled = enabled

  require("codeium").setup({
  })

  vim.keymap.set("i", "<C-g>", function() return vim.fn["codeium#Accept"]() end, { expr = true })
  vim.keymap.set("i", "<c-;>", function() return vim.fn["codeium#CycleCompletions"](1) end, { expr = true })
  vim.keymap.set("i", "<c-,>", function() return vim.fn["codeium#CycleCompletions"](-1) end, { expr = true })
  vim.keymap.set("i", "<c-x>", function() return vim.fn["codeium#Clear"]() end, { expr = true })
  vim.keymap.set("n", "<leader>;", function()
    if vim.g.codeium_enabled == true then
      vim.cmd "CodeiumDisable"
    else
      vim.cmd "CodeiumEnable"
    end
  end, { noremap = true, desc = "Toggle Codeium active" })
end

return M
