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
set nomodeline
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

let mapleader = " " " space is <Leader>-Key

nnoremap <leader>c "+y
nnoremap <leader>v <esc>:set paste<cr>"+p<esc>:set nopaste<cr>

noremap <leader>w <esc>:w<cr>
noremap <leader>q <esc>:q<cr>
nnoremap <a-k> <c-w>k
nnoremap <a-j> <c-w>j
nnoremap <a-l> <c-w>l
nnoremap <a-h> <c-w>h

inoremap <c-u> <esc>viwU

inoremap jk <esc>
nnoremap H ^
nnoremap L $
nnoremap Q <nop>
nnoremap ; :

" vim configs
nnoremap <leader>ev :split $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>ez :split ~/.zshrc<cr>
nnoremap <leader>ei :split ~/.i3/config<cr>



" highlight all occurrence of a word by clicking on it
nnoremap <silent> <2-LeftMouse> :let @/='\V\<'.escape(expand('<cword>'), '\').'\>'<cr>:set hls<cr>

" Plugin Mappings
nnoremap <eeader>o <esc>:FZF<cr>
"1}}}

" ---------- Abbreviations ----------
autocmd FileType makedown call ModeMarkdown()
function! ModeMarkdown()
    iabbrev foldme <!-- {{{1 --><cr><cr><!-- 1}}} -->
endfunction

