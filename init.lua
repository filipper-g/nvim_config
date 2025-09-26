-- external Program dependencies:
-- ->Clangd
-- ->treesitter
--   ->node.js
--   ->Clang (only c compiler)
-- ->grep
-- ->gopls

local vimrc = vim.fn.stdpath("config") .. "/vimrc.vim"
vim.cmd.source(vimrc)

vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.tabstop = 3
vim.opt.shiftwidth = 3
vim.opt.expandtab = false
vim.opt.signcolumn = "yes"

vim.opt.termguicolors = true
require("bufferline").setup{}

local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local on_attach = function(client, bufnr)
  local buf = vim.lsp.buf
  local diag = vim.diagnostic
  local opts = { noremap = true, silent = true, buffer = bufnr }

  -- LSP functions
  vim.keymap.set('n', 'K', buf.hover, opts)
  vim.keymap.set('n', 'gd', buf.definition, opts)
  vim.keymap.set('n', 'gD', buf.declaration, opts)
  vim.keymap.set('n', 'gi', buf.implementation, opts)
  vim.keymap.set('n', 'gr', buf.references, opts)
  vim.keymap.set('n', '<leader>rn', buf.rename, opts)
  vim.keymap.set('n', '<leader>ca', buf.code_action, opts)
  vim.keymap.set('n', '<leader>f', function() buf.format { async = true } end, opts)

  -- Diagnostics
  vim.keymap.set('n', '[d', diag.goto_prev, opts)
  vim.keymap.set('n', ']d', diag.goto_next, opts)
  vim.keymap.set('n', 'gl', diag.open_float, opts)
  vim.keymap.set('n', '<leader>e', diag.setloclist, opts)
end

lspconfig.clangd.setup({
  cmd = { "C:/Program Files/LLVM/bin/clangd.exe" },
  capabilities = capabilities,
  on_attach = on_attach
})

lspconfig.gopls.setup({
   settings = {
     gopls = {
       analyses = {
         unusedparams = true,
       },
       staticcheck = true,
       gofumpt = true,
     },
   },
	on_attach = on_attach,
  	capabilities = capabilities
})

local cmp = require('cmp')
cmp.setup({
  window = {
      --completion = cmp.config.window.bordered(),
      --documentation = cmp.config.window.bordered(),  -- adds border to doc popup
    },
  mapping = cmp.mapping.preset.insert({
    ['<C-k>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4), 
    ['<C-f>'] = cmp.mapping.scroll_docs(4),  
  }),
  sources = {
    { name = 'nvim_lsp' },
  },
})

--if nvim starts at certain directory change to home
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		local cwd = vim.fn.getcwd()
		local home = vim.env.USERPROFILE
		if cwd == "C:\\Program Files\\Neovide" then
      	-- Change to your preferred directory
      	vim.cmd("cd " .. home)
			vim.cmd("Ex")
		end
  end,
})

--treesitter
require'nvim-treesitter.install'.compilers = { "C:\\Program Files\\LLVM\\bin\\clang.exe"}
require'nvim-treesitter.configs'.setup {
  -- languages you want parsers for
  ensure_installed = { "c", "go"},

  sync_install = false,
  auto_install = true,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },

  indent = { enable = true },
}
