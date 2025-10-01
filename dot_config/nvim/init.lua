vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.clipboard = "unnamedplus"
vim.opt.signcolumn = "yes"
vim.keymap.set("n", "<Leader>c", function()
  vim.cmd("edit " .. vim.fn.stdpath("config") .. "/init.lua")
end)
vim.keymap.set({ "n", "i" }, "<C-s>", "<Esc>:update<CR>", { silent = true })
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

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    {
      "smoka7/hop.nvim",
      version = "*",
      keys = {
        {
          "<Leader><Space>",
          function()
            require("hop").hint_words()
          end,
          mode = "",
        },
      },
      opts = {},
    },
    {
      "nvim-lualine/lualine.nvim",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      opts = {
        -- options = {
        --   theme = "wombat",
        --   section_separators = "",
        --   component_separators = "",
        -- },
      },
    },
    {
      "windwp/nvim-autopairs",
      event = "InsertEnter",
      opts = {},
    },
    {
      "kylechui/nvim-surround",
      version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
      -- event = "VeryLazy",
      opts = {},
    },
    {
      "shortcuts/no-neck-pain.nvim",
      version = "*",
    },
    {
      "saghen/blink.cmp",
      dependencies = { "rafamadriz/friendly-snippets" },
      version = "1.*",
      ---@module "blink.cmp"
      ---@type blink.cmp.Config
      opts = {
        keymap = { preset = "default" },
        appearance = { nerd_font_variant = "mono" },
        completion = { documentation = { auto_show = false } },
        sources = { default = { "lsp", "path", "snippets", "buffer" } },
        fuzzy = { implementation = "prefer_rust_with_warning" },
      },
      opts_extend = { "sources.default" },
    },
    {
      "nvim-telescope/telescope.nvim",
      tag = "0.1.8",
      dependencies = { "nvim-lua/plenary.nvim" },
      config = function()
        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<Leader>f", builtin.find_files, { desc = "Telescope find files" })
      end,
    },
    {
      "neovim/nvim-lspconfig",
      config = function()
        vim.lsp.config("lua_ls", {
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
            },
          },
        })
        vim.lsp.enable({
          "lua_ls",
          "pyright",
        })
      end,
    },
    {
      "stevearc/conform.nvim",
      opts = {
        formatters_by_ft = {
          lua = { "stylua" },
          -- python = { "isort", "black" },
        },
        formatters = {
          stylua = function()
            local config_path = vim.fn.findfile("stylua.toml", vim.fn.getcwd() .. ";")
            if config_path ~= "" then
              return {
                exe = "stylua",
                args = { "--config-path", config_path, "-" },
                stdin = true,
              }
            else
              return {
                exe = "stylua",
                args = { "--indent-type", "Spaces", "--indent-width", "2", "-" },
                stdin = true,
              }
            end
          end,
        },
      },
    },
    {
      "nvim-treesitter/nvim-treesitter",
      branch = "main",
      lazy = false,
      build = ":TSUpdate",
      -- opts = {},
    },
    {
      "catppuccin/nvim",
      config = function()
        vim.cmd.colorscheme("catppuccin-mocha")
      end,
    },
    -- {
    --   "EdenEast/nightfox.nvim",
    --   config = function()
    --     vim.cmd.colorscheme("nightfox")
    --   end,
    -- },
  },
  checker = { enabled = true },
})
