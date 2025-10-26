call plug#begin()

Plug 'morhetz/gruvbox'              "colortheme

Plug 'neovim/nvim-lspconfig'        "lsp configuration

Plug 'hrsh7th/nvim-cmp'             "code completion
Plug 'hrsh7th/cmp-buffer'           "code completion
Plug 'hrsh7th/cmp-path'             "code completion
Plug 'hrsh7th/cmp-cmdline'          "code completion
Plug 'hrsh7th/cmp-nvim-lsp'         "code completion

Plug 'nvim-tree/nvim-web-devicons' "for coloured icons
Plug 'akinsho/bufferline.nvim', { 'tag': '*' } "tabline for buffers

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} "treesitter

Plug 'nvim-tree/nvim-tree.lua'
call plug#end()


syntax enable
set background=dark
colorscheme gruvbox
filetype plugin indent on
