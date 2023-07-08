local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- require'lspconfig'.cssls.setup {
-- 	capabilities = capabilities,
-- }

vim.g.markdown_fenced_languages = {
	"ts=typescript"
}

-- local lsp = require('lsp-zero').preset({
-- 	name = 'minimal',
-- 	set_lsp_keymaps = true,
-- 	manage_nvim_cmp = true,
-- 	suggest_lsp_servers = false,
-- })

local lsp = require('lsp-zero');

lsp.preset('recommended')

lsp.setup()

-- (Optional) Configure lua language server for neovim
lsp.nvim_workspace()

lsp.setup()

-- local config = {
--   cmd = {
--     "jdtls",
--     "-configuration",
--     "$HOME/.cache/jdtls/config",
--     "-data",
--     "-Dlog.protocol=true",
--     "$HOME/.cache/jdtls/workspace",
--     --增加lombok插件支持，getter setter good bye
--     "-javaagent:/usr/lib/lombok-common/lombok.jar",
--   }
-- }
--
-- -- require'lspconfig'.java_language_server.setup{ cmd = {"/usr/share/java/java-language-server/lang_server_linux.sh"} }
-- require'lspconfig'.jdtls.setup{config}
-- require'lspconfig'.clangd.setup{}
-- require'lspconfig'.rust_analyzer.setup{}
-- -- require'lspconfig'.denols.setup{}
-- require'lspconfig'.phpactor.setup{}
-- -- require'lspconfig'.cssls.setup{}
-- -- require'lspconfig'.eslint.setup{}
-- require'lspconfig'.emmet_ls.setup{}
--
-- require'nvim-ts-autotag'.setup{}

--[[
	highlight! DiagnosticLineNrError guibg=#51202A guifg=#FF0000 gui=bold
	highlight! DiagnosticLineNrWarn guibg=#51412A guifg=#FFA500 gui=bold
	highlight! DiagnosticLineNrInfo guibg=#1E535D guifg=#00FFFF gui=bold
	highlight! DiagnosticLineNrHint guibg=#1E205D guifg=#0000FF gui=bold
--]]
vim.cmd [[
	sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=DiagnosticLineNrError
	sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=DiagnosticLineNrWarn
	sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=DiagnosticLineNrInfo
	sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=DiagnosticLineNrHint
]]

vim.diagnostic.config({
	virtual_text = {
		prefix = "●"
	},
	signs = true,
	underline = true,
	update_in_insert = true,
	severity_sort = true
})

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

--
-- require'lspconfig'.html.setup {
--   capabilities = capabilities,
-- }

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>lg', builtin.live_grep, {})

local cmp = require'cmp'

cmp.setup({
	snippet = {
		expand = function(args)
		require('luasnip').lsp_expand(args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},

	mapping = cmp.mapping.preset.insert({
	['<C-b>'] = cmp.mapping.scroll_docs(-4),
	['<C-f>'] = cmp.mapping.scroll_docs(4),
	['<C-Space>'] = cmp.mapping.complete(),
	['<C-e>'] = cmp.mapping.abort(),
	['<CR>'] = cmp.mapping.confirm({ select = true }),
	}),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
	}, {
		{ name = 'buffer' },
	})
})
