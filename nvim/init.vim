call plug#begin(stdpath('data') . '/plugged')
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    " Plug 'nvim-treesitter/nvim-treesitter'
    " Plug 'neovim/nvim-lspconfig'
    " Plug 'ojroques/vim-oscyank'
    " Plug 'tpope/vim-surround'
call plug#end()


set noswapfile

set mouse=nv
set clipboard+=unnamedplus

set number

set ignorecase
set smartcase
set hlsearch

set completeopt=noinsert,noselect,menuone
set shortmess=c
set hidden " allow switching buffer without :w

" set textwidth=79
set colorcolumn=80
highlight ColoColumn ctermbg=233

" mark trailing white spaces
highlight ExtraWhitespace ctermbg=1
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
nnoremap <leader>fw :%s/\s\+$//<cr>

" no tabs
set expandtab
set tabstop=4
set shiftwidth=4

" syntax enable
filetype plugin on


" source ~/.config/nvim/treesitter-settings.vim
" source ~/.config/nvim/markdown-settings.vim

" neovim specific
if has("nvim")

endif

"""""""" custom mappings


" c-V is already used for past from clipboard
" use c-v for blogwise visual mode
nnoremap <c-v> <c-V>

nnoremap <space> <nop>
let mapleader=" "


nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap <leader>ez :e ~/.zshrc<cr>

" fzf mappings (f prefix for fzf)
nnoremap <leader>b :Buffers<cr>
nnoremap <leader>f :FZF<cr>
nnoremap <leader>r :Rg<cr>
nnoremap <leader>h :Helptags<cr>
nnoremap <leader>c :Commands<cr>


" insert date (i prefix for insert)
nnoremap <leader>id "=strftime('%Y.%m.%d')<cr>P
nnoremap <leader>iD "=strftime('%Y.%m.%d %T')<cr>P

" toggel relative "numbering"
nnoremap <leader>rn :set relativenumber!<cr>
