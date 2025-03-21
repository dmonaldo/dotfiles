-- source env vars
local function source_vim_file(file)
  local expanded_file = vim.fn.expand(file)
  if vim.fn.filereadable(expanded_file) == 1 then
    vim.cmd("source " .. expanded_file)
  else
    print("File not found: " .. expanded_file)
  end
end
-- source the .nvim.env file
source_vim_file("~/.nvim.env")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- remap
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.wo.number = true

require("lazy").setup("plugins")

-- rename
vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, { desc = "[R]e[N]ame" })

-- set color scheme
vim.cmd([[
  colorscheme rose-pine
]])

-- load avante
require("avante_lib").load()
