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

-- netrw
g.netrw_banner = 0
g.netrw_liststyle = 3
g.netrw_browse_split = 4
g.netrw_altv = 1
g.netrw_winsize = 25

-- removing traling whitespaces on save
cmd [[au BufWritePre * :%s/\s\+$//e]]

-- open a terminal pane on the right using :Term
cmd [[command Term :botright vsplit term://$SHELL]]
-- Terminal visual tweaks
cmd [[
    autocmd TermOpen * setlocal listchars= nonumber norelativenumber nocursorline
    autocmd TermOpen * startinsert
    autocmd BufLeave term://* stopinsert
]]

-- Make sure Packer is installed
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)
  -- Plugins here
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use 'editorconfig/editorconfig-vim'
  use 'Raimondi/delimitMate'
  use 'chriskempson/base16-vim'
  use {
    'hoob3rt/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true},
  }
  -- Plugins configuration
  require('lualine').setup {
    options = {
      theme='material',
    }
  }

  -- snippet engine
  use 'dcampos/nvim-snippy'
  require('snippy').setup({
    mappings = {
        is = {
            ['<Tab>'] = 'expand_or_advance',
            ['<S-Tab>'] = 'previous',
        },
        nx = {
            ['<leader>x'] = 'cut_text',
        },
    },
  })

  use 'martinda/Jenkinsfile-vim-syntax'

  -- Collection of configurations for the built-in LSP client
  use 'neovim/nvim-lspconfig'

  -- LSP activations
  require'lspconfig'.pyright.setup{}        -- python3 -m pip install pyright
  require'lspconfig'.bashls.setup{}         -- npm i -g bash-language-server
  require'lspconfig'.terraformls.setup{}    -- brew install hashicorp/tap/terraform-ls
  require'lspconfig'.ansiblels.setup{}      -- npm install -g @ansible/ansible-language-server

  map('n', '<Leader>ff',[[<cmd>lua require('telescope.builtin').find_files({previewer = false})<CR>]] , {noremap = true})
  map('n', '<leader>bb', [[<cmd>lua require('telescope.builtin').buffers({previewer = false})<CR>]], {noremap = true})
  map('n', '<leader>fg', [[<cmd>lua require('telescope.builtin').live_grep({})<CR>]], {noremap = true})

  -- Automatically set up configuration after cloning packer.nvim
  if packer_bootstrap then
    require('packer').sync()
  end
end)
