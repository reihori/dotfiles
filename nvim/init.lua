vim.g.mapleader = " "

require("_lazy")

vim.o.relativenumber = true

vim.keymap.set("n", "<leader>w", "<cmd>update<cr>", {})

local mygroup = vim.api.nvim_create_augroup("mygroup", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	group = mygroup,
	pattern = "lua",
	callback = function()
		vim.bo.tabstop = 4
	end
})

vim.api.nvim_create_user_command("Cfg",
	function()
		vim.cmd.edit("~/.config/nvim/init.lua")
	end,
	{}
)
