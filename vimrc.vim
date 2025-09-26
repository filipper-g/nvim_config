call plug#begin()

Plug 'rust-lang/rust.vim'
Plug 'morhetz/gruvbox'

Plug 'neovim/nvim-lspconfig'

Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-nvim-lsp'   

Plug 'nvim-tree/nvim-web-devicons' " Recommended (for coloured icons)
Plug 'akinsho/bufferline.nvim', { 'tag': '*' }

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
call plug#end()


syntax enable
set background=dark
colorscheme gruvbox
filetype plugin indent on

" Always open netrw in a vertical split on the left
let g:netrw_browse_split = 0
" let g:netrw_altv = 1
let g:netrw_liststyle = 3 " tree-style listing
let g:netrw_winsize = 25  " width in columns

" Hide banner for a cleaner look
let g:netrw_banner = 0
