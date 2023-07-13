--[[
==================================
        Tired Fox Config
==================================
Origin: https://github.com/nvim-lua/kickstart.nvim

Forked from kickstart.nvim as a simple starter template. The core template has been
modified to handle multiple files and to toggle a few extra options. All plugins are moved
to the plugins directory.
--]]

-- Set keymap leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set up lazy.nvim as a plugin manager
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- Import rest of config through their own dedicated files
require('lazy').setup('plugins')
require('keymaps')
require('autocmds')
require('lsp')
require('options')
