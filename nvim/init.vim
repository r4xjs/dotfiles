let mapleader = " " " space is <leader>-Key
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
set colorcolumn=81
set ignorecase
set showcmd
set cursorline

set guioptions-=T
set nocompatible 

set laststatus=2
set statusline=%F

set encoding=utf-8

"1}}}

" ---------- Plugins ----------
" {{{1
call plug#begin('~/.local/share/nvim/plugged')

Plug 'flazz/vim-colorschemes'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'rhysd/vim-grammarous'
Plug 'keith/swift.vim'
Plug 'leafgarland/typescript-vim'
Plug 'plasticboy/vim-markdown'
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'zchee/deoplete-clang'

call plug#end()
" 1}}}

" Plugin Settings
" {{{1
let g:grammarous#hooks = {}
let g:grammarous#show_first_error = 1
let g:grammarous#use_vim_spelllang = 0
let g:grammarous#enable_spell_check = 1


let g:vim_markdown_follow_anchor = 1
let g:vim_markdown_autowrite = 1
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_new_list_item_indent = 0


let g:deoplete#enable_at_startup = 1


" Plugin Mappings
nnoremap <leader>p <esc>:FZF<cr>
nnoremap <leader>t <esc>:Tags<cr>

function! g:grammarous#hooks.on_check(errs) abort
    echom "check triggered"
    nnoremap <buffer><leader>gn <plug>(grammarous-move-to-next-error)
endfunction
function! g:grammarous#hooks.on_reset(errs) abort
    echom "reset triggered"
    nunmap <buffer><leader>gn
endfunction


" 1}}}

" ---------- Color Scheme Settings ----------
" {{{1
" set background=dark
set t_Co=256
colorscheme iceberg
"1}}}

"  ---------- Key Bindings  ----------
" {{{1

" vnoremap <leader>c "+y
vnoremap <c-c> "+y
vnoremap <a-c> "+y
nnoremap <leader>n <esc>:let @+ = expand("%")<cr>
nnoremap <leader>v <esc>:set paste<cr>"+p<esc>:set nopaste<cr>

nnoremap <F5> <Esc>:w<CR>:!./build_and_run.sh<CR>

noremap <leader>w <esc>:w!<cr>
noremap <leader>q <esc>:q!<cr>
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
nnoremap <leader>c :!ctags -R .<cr>
nnoremap <a-left> <c-t>
nnoremap <c-t> <nop>

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

"1}}}

" ---------- Mouse ----------
" {{{1
noremap <ScrollWheelUp>     4<C-Y>
noremap <ScrollWheelDown>   4<C-E>
" 1}}}

" ---------- Abbreviations ----------
function! ModeMarkdown()
    iabbrev <buffer> foldme <!-- {{{1 --><cr><cr><!-- 1}}} -->
    iabbrev <buffer> foldme2 <!-- {{{2 --><cr><cr><!-- 2}}} -->
endfunction
function! ModePython()
    iabbrev <buffer> foldme # {{{1 <cr><cr># 1}}}
endfunction
function! ModeVim()
    iabbrev <buffer> foldme " {{{1 <cr><cr>" 1}}}
endfunction
function! ModeC()
    iabbrev <buffer> main #include <stdio.h>
\<cr>#include <stdlib.h>
\<cr>#include <stdint.h>
\<cr>
\<cr>int main(int argc, char** argv){  
\<cr>
\<cr>return 0;
\<cr>}
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
:augroup filetype_c
:    autocmd!
:    autocmd FileType c :call ModeC()
:augroup end

" 1}}}


" ---------- Project Settings ----------
" {{{1 
"
if getcwd() =~ "nullscan"
    function! Sn00pMode()
        :setlocal shiftwidth=2
        :setlocal tabstop=2
        :setlocal softtabstop=2

        " whitespaces
        autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
        highlight ExtraWhitespace ctermbg=cyan guibg=cyan
        autocmd InsertLeave * redraw!
        match ExtraWhitespace /\s\+$\| \+\ze\t/
        autocmd BufWritePre * :%s/\s\+$//e

    endfunction
    :augroup proj_filetype_python
        autocmd!
        autocmd  FileType python :call Sn00pMode()
    :augroup end
endif

" 1}}} 
