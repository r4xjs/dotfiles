" ---------- General Settings ----------
" {{{1
set number
set relativenumber
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
" set textwidth=80
set colorcolumn=81
set ignorecase
set showcmd

set guioptions-=T
set nocompatible 
"1}}}

" ---------- Plugins ----------
" {{{1
call plug#begin('~/.local/share/nvim/plugged')

Plug 'flazz/vim-colorschemes'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

call plug#end()
" 1}}}

" ---------- Color Scheme Settings ----------
" {{{1
" set background=dark
set t_Co=256
colorscheme iceberg
"1}}}

"  ---------- Key Bindings  ---------- 
" {{{1
let mapleader = " " " space is <leader>-Key

vnoremap <leader>c "+y
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

" ctags
nnoremap <leader>t :!ctags -R .<cr>   

"noremap <silent> <leader>m :<c-u>let @/='\V\<'.escape(expand('<cword>'), '\').'\>'<cr>

" Matching Group Bindings
noremap <silent> <leader>m1 :<c-u>execute ":1match SpellCap /".expand('<cword>')."/"<cr>
noremap <silent> <leader>m2 :<c-u>execute ":2match DiffAdd /".expand('<cword>')."/"<cr>
noremap <silent> <leader>m3 :<c-u>execute ":3match SpellRare /".expand('<cword>')."/"<cr>
nnoremap <silent> <leader>n1 :1match none<cr>
nnoremap <silent> <leader>n2 :2match none<cr>
nnoremap <silent> <leader>n3 :3match none<cr>

" Search Bindings
nnoremap / /\V
nnoremap <silent> <leader><leader> :let @/=''<cr>

" Plugin Mappings
nnoremap <leader>p <esc>:FZF<cr>
"1}}}

" ---------- Snippets ----------
" {{{1 
" nnoremap ,html :-1read $HOME/.vim/.skeleton.html<cr>3jwf>a
" 1}}} 

" ---------- Abbreviations ----------
function! ModeMarkdown()
    iabbrev <buffer> foldme <!-- {{{1 --><cr><cr><!-- 1}}} -->
endfunction
function! ModePython()
    iabbrev <buffer> foldme # {{{1 <cr><cr># 1}}}
endfunction
function! ModeVim()
    iabbrev <buffer> foldme " {{{1 <cr><cr>" 1}}}
endfunction

" {{{1 
:augroup filetype_markdown
:    autocmd!
:    autocmd FileType markdown :call ModeMarkdown()
:augroup end
:augroup filetype_python
:    autocmd!
:    autocmd FileType python :call ModePython()
:augroup end
:augroup filetype_vim
:    autocmd!
:    autocmd FileType vim :call ModeVim()
:augroup end
" 1}}} 


" ---------- Project Settings ----------
if getcwd() =~ "sn00p"
    :augroup proj_filetype_python
        autocmd!
        autocmd  FileType python :setlocal shiftwidth=2
    :augroup end
endif
