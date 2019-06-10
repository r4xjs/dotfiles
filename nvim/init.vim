let mapleader = " " " space is <Leader>-Key
" ---------- General Settings ----------
" {{{1
set number
syntax on
set undofile
set undodir="~/.vim_undo_files"
set noswapfile
set hlsearch
set incsearch
set shiftwidth=4
set tabstop=4
set smarttab
set nosmartindent
set foldmethod=marker
set guicursor=
set expandtab
set mouse=a
"1}}}

" ---------- Plugins ----------
" {{{1
call plug#begin('~/.local/share/nvim/plugged')

Plug 'flazz/vim-colorschemes'
Plug 'junegunn/fzf.vim'

call plug#end()
" 1}}}

" ---------- Color Scheme Settings ----------
" {{{1
" set background=dark
set t_Co=256
colorscheme iceberg

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
"1}}}


"  ---------- Key Bindings  ---------- 
" {{{1
"autocmd FileType c,cpp,h,hpp,cc setlocal foldmethod=syntax
autocmd FileType dot map <F5> :w<CR>:!xdot "%"<CR>
autocmd FileType python map <F5> :w<CR>:!python2 "%"<CR>

map <Leader>c "+y
map <Leader>v <Esc>:set paste<CR>"+p<Esc>:set nopaste<CR>
map <Leader>w <Esc>:w<CR>
map <Leader>q <Esc>:q<CR>

imap jk <esc>
nnoremap Q <nop>
nnoremap ; :

" highlight all occurrence of a word by clicking on it
nnoremap <silent> <2-LeftMouse> :let @/='\V\<'.escape(expand('<cword>'), '\').'\>'<cr>:set hls<cr>

" Plugin Mappings
map <Leader>o <Esc>:FZF<CR>
"1}}}
