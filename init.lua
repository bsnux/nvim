-- 
-- NeoVim configuration
-- 
local o = vim.o				-- global options
local wo = vim.wo			-- window scope options
local bo = vim.bo			-- buffer scope options
local fn = vim.fn
local cmd = vim.cmd
local opt = vim.opt
local g = vim.g
local map = vim.api.nvim_set_keymap

-- Making sure `packer` is installed
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd 'packadd packer.nvim'
end

wo.number = true

o.mouse = 'a'
o.colorcolumn = '80'

opt.splitbelow = true
opt.splitright = true

opt.tabstop = 2         -- number of spaces tabs count for
opt.expandtab = true    -- using spaces instead of tabs
opt.shiftwidth = 2      -- size of an indent

opt.termguicolors = true 
cmd "colo base16-ocean"

g.mapleader = ','

-- Mappings
map('n', '<C-l>', '<cmd>noh<CR>', {})

-- Emacs keybindings
map('i', '<c-a>', '<Home>', {})
map('i', '<c-e>', '<End>', {})
map('i', '<c-k>', '<Esc>d$i', {})
map('i', '<c-b>', '<Esc>i', {})
map('i', '<c-f>', '<Esc>lli', {})

-- Plugins configuration
local packer = require'packer'
packer.startup(function()
  local use = use
  use 'wbthomason/packer.nvim'
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use 'editorconfig/editorconfig-vim'
  use 'Raimondi/delimitMate'
  use 'chriskempson/base16-vim'
  use 'neovim/nvim-lspconfig'
  use {
    'hoob3rt/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }
  end
)

require'lualine'.setup {
  options = {
    theme = 'material',
  }
}

require'lspconfig'.gopls.setup{}

map('n', '<Leader>ff',[[<cmd>lua require('telescope.builtin').find_files({previewer = false})<CR>]] , {noremap = true})
map('n', '<leader>bb', [[<cmd>lua require('telescope.builtin').buffers({previewer = false})<CR>]], {noremap = true})
map('n', '<leader>fg', [[<cmd>lua require('telescope.builtin').live_grep({})<CR>]], {noremap = true})
