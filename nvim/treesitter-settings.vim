lua <<EOF
require'nvim-treesitter.configs'.setup {
    highlight = { enable = true },
    incremental_selection = { enable = true },
    textobjects = { enable = true },

    ensure_installed = {
        'c',
        'python',
        'rust',
        'lua',
        'json',
        'cpp',
        'bash',
    }
}
EOF

" set foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()
