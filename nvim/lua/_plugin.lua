return {
	{ "EdenEast/nightfox.nvim" },
	{ "williamboman/mason.nvim", opts = {} },
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			local cfg = require("mason-lspconfig")
			cfg.setup({ ensure_installed = { "lua_ls", "pyright", "tsserver" } })
			cfg.setup_handlers({
				function(server_name)
					require("lspconfig")[server_name].setup({})
				end,
			})
		end
	},
	{ "neovim/nvim-lspconfig" },
	{
		"hadronized/hop.nvim",
		config = function()
			local hop = require("hop")
			hop.setup()
			vim.keymap.set("n", "e", hop.hint_char1, {})
		end
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
		},
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "buffer" }
				})
			})
		end
	},
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "lua", "python" },
				highlight = {
					enable = true
				}
			})
		end
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" }
	},
	{
		"nvim-tree/nvim-tree.lua",
		config = function()
			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1
			-- vim.opt.termguicolors = true
			require("nvim-tree").setup()
		end
	}
}
