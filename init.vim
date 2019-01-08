"
" Plugins
"     Installing `Plug`:
"     $ curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
"       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" ----------------------------------------------------------------------------

call plug#begin('~/.local/share/nvim/plugged')

Plug 'morhetz/gruvbox'
Plug 'tpope/vim-fugitive'
Plug 'jreybert/vimagit'
Plug 'neomake/neomake'
Plug 'itchyny/lightline.vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-go'
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
Plug 'scrooloose/nerdcommenter'
Plug 'w0rp/ale'
Plug 'majutsushi/tagbar'
Plug 'jaywilliams/vim-vwilight'
Plug 'joshdick/onedark.vim'
Plug 'SirVer/ultisnips'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }}
Plug 'terryma/vim-multiple-cursors'

call plug#end()

" ---- Default keybindings:
"     <leader>,w	Easy motion
"     <C-o>		Jump backward
"     <C-i>		Jump forward

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

set cursorline

" Tell Vim which characters to show for expanded TABs,
" trailing whitespace, and end-of-lines. VERY useful!
"if &listchars ==# 'eol:$'
"  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
"endif
"set list

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
" colorscheme darcula
colorscheme onedark

" Find merge conflict markers
map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR><Paste>

" Open a new tab
ca tn tabnew

" Emacs keybiding for insert mode
imap <C-e> <esc>$a
imap <C-a> <esc>0i
imap <C-f> <esc>lli
imap <C-b> <esc>i

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
let g:netrw_winsize = 15
let g:netrw_browse_split = 2
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:NetrwIsOpen=0

function! ToggleNetrw()
    if g:NetrwIsOpen
        let i = bufnr("$")
        while (i >= 1)
            if (getbufvar(i, "&filetype") == "netrw")
                silent exe "bwipeout " . i 
            endif
            let i-=1
        endwhile
        let g:NetrwIsOpen=0
    else
        let g:NetrwIsOpen=1
        silent Lexplore
    endif
endfunction
map <silent> <C-E> :call ToggleNetrw()<CR>

" Go files
autocmd BufNewFile,BufRead *.go setlocal tabstop=2 shiftwidth=2

" Jenkinsfile
autocmd BufNewFile,BufRead Jenkinsfile set ft=groovy

" Bash
" show existing tab with 4 spaces width:       set tabstop=2
" when indenting with '>', use 4 spaces width: set shiftwidth=2
" On pressing tab, insert 4 spaces:            set expandtab
autocmd BufNewFile,BufRead *.sh set tabstop=2 shiftwidth=2 expandtab

" Python
au BufNewFile,BufRead *.py set tabstop=4 softtabstop=4 shiftwidth=4 expandtab autoindent

" JS
au BufNewFile,BufRead *.js set tabstop=2 softtabstop=2 shiftwidth=2 expandtab autoindent

" Markdown
au BufRead,BufNewFile *.md setlocal textwidth=80

set inccommand=nosplit

" Move current line up
nmap <C-S-Up> ddkP

" Move current line down
nmap <C-S-Down> ddp

" This will work out of the box for GUI Nvim
set autoread

" Format document
nmap <leader>f gg=G

" Remove trailing whitespaces with F5
function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
nnoremap <silent> <F5> :call <SID>StripTrailingWhitespaces()<CR>

" Change local working dir upon tab creation
autocmd BufEnter * silent! lcd %:p:h
function! OnTabEnter(path)
  if isdirectory(a:path)
    let dirname = a:path
  else
    let dirname = fnamemodify(a:path, ":h")
  endif
  execute "tcd ". dirname
endfunction()

autocmd TabNewEntered * call OnTabEnter(expand("<amatch>"))

" ---- Plugins configuration

" ale
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'

" vim-go
let g:go_fmt_command = "goimports"
let g:go_auto_type_info = 1
"   Ctrl-t go back
autocmd FileType go nmap <silent> <Leader>d <Plug>(go-def-tab)
"   Enable deoplete on startup
let g:deoplete#enable_at_startup = 1

" nerdcommenter
map <C-\> <plug>NERDCommenterToggle

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

" UltiSnips
let g:UltiSnipsExpandTrigger="<tab>"
