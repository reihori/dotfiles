vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.clipboard = "unnamedplus"
vim.opt.list = true
vim.opt.signcolumn = "yes"

vim.keymap.set("n", "<Leader>c", function()
  vim.cmd("edit " .. vim.fn.stdpath("config") .. "/init.lua")
end)

vim.keymap.set({ "n", "i" }, "<C-s>", "<Esc>:update<CR>", { silent = true })
vim.keymap.set({ "n", "i" }, "<C-n>", "<Esc>:bnext<CR>", { silent = true })
vim.keymap.set({ "n", "i" }, "<C-p>", "<Esc>:bprevious<CR>", { silent = true })

vim.keymap.set("i", "<C-a>", "<Esc>I")
vim.keymap.set("i", "<C-e>", "<Esc>A")
vim.keymap.set("i", "<C-b>", "<Left>")
vim.keymap.set("i", "<C-f>", "<Right>")

local indent_configs = {
  fish = { size = 4, expandtab = true },
  lua = { size = 2, expandtab = true },
  sh = { size = 4, expandtab = true },
  zsh = { size = 4, expandtab = true },
}
vim.api.nvim_create_autocmd("FileType", {
  pattern = vim.tbl_keys(indent_configs),
  callback = function(ev)
    local c = indent_configs[ev.match]
    if c then
      vim.opt_local.shiftwidth = c.size
      vim.opt_local.tabstop = c.size
      vim.opt_local.softtabstop = c.size
      vim.opt_local.expandtab = c.expandtab
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    pcall(vim.treesitter.start)
  end,
})

vim.pack.add({
  "https://github.com/catppuccin/nvim",
  "https://github.com/nvim-mini/mini.nvim",
  "https://github.com/smoka7/hop.nvim",
})

vim.cmd.colorscheme("catppuccin-mocha")

require("mini.pairs").setup()

require("mini.statusline").setup()

local hop = require("hop")
hop.setup()
vim.keymap.set("n", "<Leader><Space>", function()
  hop.hint_words()
end)
