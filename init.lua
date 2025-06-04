vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")

-- Key mappings
vim.keymap.set('n', '<leader>w', ':w<CR>', {
  noremap = true,
  silent = true,
  desc = "[W]rite current [B]uffer"
})

vim.keymap.set('n', '<leader>q', ':q<CR>', {
  noremap = true,
  silent = true,
  desc = '[Q]uit current window',
})

vim.keymap.set('i', 'jj', '<Esc>', {
  noremap = true,
  silent = true,
  desc = 'Return to Normal mode'
})

-- Yank
vim.keymap.set('v', '<leader>y', '"+y', {
  noremap = true,
  silent = true,
  desc = '[Y]ank selected text to system clipboard',
})

vim.keymap.set('n', '<leader>Y', '"+yg_', {
  noremap = true,
  silent = true,
  desc = '[Y]ank from cursor to end of line to system clipboard excluding newline',
})

vim.keymap.set('n', '<leader>yy', '"+yy', {
  noremap = true,
  silent = true,
  desc = '[Y]ank current line to system clipboard',
})

-- Paste
vim.keymap.set('n', '<leader>p', '"+p', {
  noremap = true,
  silent = true,
  desc = '[P]aste after cursor from system clipboard',
})

vim.keymap.set('n', '<leader>P', '"+P', {
  noremap = true,
  silent = true,
  desc = '[P]aste before cursor from system clipboard',
})
