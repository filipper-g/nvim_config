-- external Program dependencies:
-- ->Clangd
-- ->treesitter   (optional)
--   ->node.js
--   ->Clang (c compiler)
-- ->grep  (optional)
-- ->gopls (optional)
-- ->texlab (optional)

--system specific parameters:
local clangd_path="C:\\Program Files\\LLVM\\bin\\clangd.exe"
local clang_path="C:\\Program Files\\LLVM\\bin\\clang.exe"
local neovide_dir="C:\\Program Files\\Neovide"
local neovim_dir="C:\\Program Files\\Neovim"
local texlab_path="C:\\Program Files\\texlab\\texlab.exe"
local gopls_installed=true
local tresitter_installed=true
local texlab_installed=true

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

--load vimrc file (mostly for vimplug)
local vimrc = vim.fn.stdpath("config") .. "/vimrc.vim"
vim.cmd.source(vimrc)
vim.api.nvim_create_user_command('Ert', 'NvimTreeToggle', {})
--some options
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.tabstop = 3
vim.opt.shiftwidth = 3
vim.opt.expandtab = false
vim.opt.signcolumn = "yes"

vim.opt.termguicolors = true
require("bufferline").setup{}

require("nvim-tree").setup()

--lsp settings
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
	--Diagnostics
	vim.keymap.set('n', '[d', diag.goto_prev, opts)
	vim.keymap.set('n', ']d', diag.goto_next, opts)
	vim.keymap.set('n', 'gl', diag.open_float, opts)
	vim.keymap.set('n', '<leader>e', diag.setloclist, opts)
end

lspconfig.clangd.setup({
	cmd = { clangd_path },
	capabilities = capabilities,
	on_attach = on_attach
})

if gopls_installed == true then
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
end

if texlab_installed == true then
	lspconfig.texlab.setup({
		cmd = { texlab_path },
		on_attach = on_attach,
		capabilities = capabilities
	})
end

-- code completion settings
local cmp = require('cmp')
cmp.setup({
	window = {
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
		if cwd == neovide_dir or cwd == neovim_dir then
			-- Change to your preferred directory
			vim.cmd("cd " .. home)
			-- vim.cmd("Ex")
		end
	end,
})

--treesitter
if treesitter_installed==true then
	require'nvim-treesitter.install'.compilers = { clang_path }
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
end
