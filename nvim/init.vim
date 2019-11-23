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

" vnoremap <leader>c "+y
vnoremap <c-c> "+y
vnoremap <a-c> "+y
nnoremap <leader>v <esc>:set paste<cr>"+p<esc>:set nopaste<cr>

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

" Plugin Mappings
nnoremap <leader>p <esc>:FZF<cr>
nnoremap <leader>t <esc>:Tags<cr>
let g:grammarous#hooks = {}
let g:grammarous#show_first_error = 1
let g:grammarous#use_vim_spelllang = 0
let g:grammarous#enable_spell_check = 1
function! g:grammarous#hooks.on_check(errs) abort
    echom "check triggered"
    nnoremap <buffer><leader>gn <plug>(grammarous-move-to-next-error)
endfunction
function! g:grammarous#hooks.on_reset(errs) abort
    echom "reset triggered"
    nunmap <buffer><leader>gn
endfunction

"1}}}

" ---------- Mouse ----------
" {{{1
noremap <ScrollWheelUp>     4<C-Y>
noremap <ScrollWheelDown>   4<C-E>
" 1}}}

" ---------- Snippets ----------
" {{{1
" nnoremap ,html :-1read $HOME/.vim/.skeleton.html<cr>3jwf>a
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

augroup XML
    autocmd!
    " autocmd FileType xml setlocal foldmethod=indent foldlevelstart=999 foldminlines=0
augroup END

" ---------- Project Settings ----------
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
