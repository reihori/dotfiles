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

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "lua", "sh", "zsh" },
  callback = function(ev)
    local opts = {
      lua = { shiftwidth = 2, tabstop = 2, softtabstop = 2, expandtab = true },
      sh = { shiftwidth = 4, tabstop = 4, softtabstop = 4, expandtab = true },
      zsh = { shiftwidth = 4, tabstop = 4, softtabstop = 4, expandtab = true },
    }
    local o = opts[ev.match]
    if o then
      for k, v in pairs(o) do
        vim.opt_local[k] = v
      end
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "javascript",
    "lua",
    "python",
  },
  callback = function()
    vim.treesitter.start()
  end,
})

vim.pack.add({
  "https://github.com/catppuccin/nvim",
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/nvim-lualine/lualine.nvim",
  "https://github.com/nvim-mini/mini.nvim",
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/smoka7/hop.nvim",
  "https://github.com/stevearc/conform.nvim",
})

vim.cmd.colorscheme("catppuccin-mocha")

require("lualine").setup()

local hop = require("hop")
hop.setup()
vim.keymap.set("n", "<Leader><Space>", function()
  hop.hint_words()
end)

require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "ruff_format" },
  },
})

vim.lsp.enable({
  "lua_ls",
  "pyright",
})

require("mini.pairs").setup()
local MiniPick = require("mini.pick")
MiniPick.setup()
vim.keymap.set("n", "<Leader>f", function()
  MiniPick.builtin.files()
  -- MiniPick.builtin.files({ tool = 'git' })
end, { desc = "mini.pick.files" })
