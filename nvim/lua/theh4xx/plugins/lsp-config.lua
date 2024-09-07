return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "gopls", "clangd" },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local lspconfig = require("lspconfig")

			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})
			-- Simplified configuration for gopls in Neovim
			lspconfig.gopls.setup({
				capabilities = capabilities,
				on_attach = function(_, bufnr)
					local bufopts = { noremap = true, silent = true, buffer = bufnr }

					-- Essential key mappings
					vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
				end,
			})

			lspconfig.clangd.setup({
				cmd = {
					"clangd",
					"--background-index",
					"--clang-tidy", -- Enable clang-tidy
					"--completion-style=bundled",
					"--cross-file-rename",
					"--header-insertion=iwyu",
					-- Optional: Specify a particular clang-tidy configuration file or checks
					-- "--clang-tidy-checks=*,-clang-analyzer-*",
				},
				capabilities = capabilities,
				on_attach = function(_, bufnr)
					local bufopts = { noremap = true, silent = true, buffer = bufnr }

					-- Key mappings specific to clangd
					vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
				end,
				init_options = {
					clangdFileStatus = true,
					usePlaceholders = true,
					completeUnimported = true,
					semanticHighlighting = true,
				},
			})
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
}
