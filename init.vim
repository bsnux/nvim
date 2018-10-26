" ----------------------------------------------------------------------------
" Neovim configuration file
"
" This file: ~/.config/nvim/init.vim
"
" Works with:
"     - Fedora 27/Neovim 0.2.2
"     - Fedora 28/Neovim 0.3.0
"     - macOS 10.13.6
"
" Plugins
"     Installing `Plug`:
"     $ curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
"       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" ----------------------------------------------------------------------------

call plug#begin('~/.local/share/nvim/plugged')

Plug 'morhetz/gruvbox'
Plug 'tpope/vim-fugitive'
Plug 'neomake/neomake'
Plug 'itchyny/lightline.vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'blueshirts/darcula'
Plug 'altercation/vim-colors-solarized'
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'editorconfig/editorconfig-vim'
Plug 'Raimondi/delimitMate'
Plug 'airblade/vim-gitgutter'
Plug 'easymotion/vim-easymotion'
Plug 'mileszs/ack.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'machakann/vim-highlightedyank'

call plug#end()

" ---- Generic configuration

set nu
au TermOpen * setlocal nonumber norelativenumber

let mapleader = ','

set colorcolumn=80
set noswapfile

tnoremap <Esc> <C-\><C-n>
set termguicolors

set splitbelow
set splitright

" Tell Vim which characters to show for expanded TABs,
" trailing whitespace, and end-of-lines. VERY useful!
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif
set list

" Also highlight all tabs and trailing whitespace characters.
"highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
"match ExtraWhitespace /\s\+$\|\t/

" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

" Set mouse
set mouse=a

" Copying to clipboard using `y`:
"     macOS: `brew install reattach-to-user-namespace`
set clipboard=unnamedplus

" Color schemes
set bg=dark
colorscheme gruvbox

" Find merge conflict markers
map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR><Paste>

" Open a new tab
ca tn tabnew

" Emacs keybiding for insert mode
imap <C-e> <esc>$a
imap <C-a> <esc>0i

" Emacs keys for command line
cnoremap <C-A>	<Home>
cnoremap <C-B>	<Left>
cnoremap <C-D>	<Del>
cnoremap <C-E>	<End>
cnoremap <C-F>	<Right>

" search for visually hightlighted text
" %s//<your-replacement-string>
vnoremap <c-f> y<ESC>/<c-r>"<CR>

" Explorer
let g:netrw_winsize = 25
let g:netrw_browse_split = 3
function! ToggleVExplorer()
  " Toggle Vexplore with Ctrl-E
  if exists("t:expl_buf_num")
      let expl_win_num = bufwinnr(t:expl_buf_num)
      if expl_win_num != -1
          let cur_win_nr = winnr()
          exec expl_win_num . 'wincmd w'
          close
          exec cur_win_nr . 'wincmd w'
          unlet t:expl_buf_num
      else
          unlet t:expl_buf_num
      endif
  else
      exec '1wincmd w'
      Vexplore
      let t:expl_buf_num = bufnr("%")
  endif
endfunction
map <silent> <C-E> :call ToggleVExplorer()<CR>

" Go files
autocmd BufNewFile,BufRead *.go setlocal tabstop=4

" Jenkinsfile
autocmd BufNewFile,BufRead Jenkinsfile set ft=groovy

" Bash
" show existing tab with 4 spaces width:       set tabstop=2
" when indenting with '>', use 4 spaces width: set shiftwidth=2
" On pressing tab, insert 4 spaces:            set expandtab
autocmd BufNewFile,BufRead *.sh set tabstop=2 shiftwidth=2 expandtab

set inccommand=nosplit

" ---- Plugins configuration

" Default keybindings:
"     <leader>,w: Easy motion

" Fugitive
nmap <leader>gs :Gstatus<cr>

" lightline
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }

" deoplete
let g:deoplete#enable_at_startup = 1

" fzf
" enter:    current window
" ctrl-t:   new tab
" ctrl-x:   horizontal split
" ctrl-v:   vertical split
map <C-p> :FZF<CR>
" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1
