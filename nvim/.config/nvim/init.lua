------------------------------------------------------------
-- Leader
------------------------------------------------------------
vim.g.mapleader = " "

------------------------------------------------------------
-- Basic options
------------------------------------------------------------
local opt = vim.opt
opt.number = true
opt.relativenumber = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.wrap = false
opt.cursorline = false
opt.termguicolors = true
opt.clipboard = "unnamedplus" -- system clipboard

------------------------------------------------------------
-- Hide Neovim UI inside tmux
------------------------------------------------------------
if vim.env.TMUX then
  opt.laststatus = 0
  opt.winbar = ""
end

------------------------------------------------------------
-- Lazy.nvim bootstrap
------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", lazypath
  })
end
opt.rtp:prepend(lazypath)

------------------------------------------------------------
-- Plugins
------------------------------------------------------------
require("lazy").setup({
  { "nvim-tree/nvim-tree.lua",         dependencies = { "nvim-tree/nvim-web-devicons" } },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    enabled = not vim.env.TMUX,
  },

  { "nvim-telescope/telescope.nvim",   dependencies = { "nvim-lua/plenary.nvim" } },

  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  { "nvim-treesitter/playground" },

  { "neovim/nvim-lspconfig" },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
       }),
        sources = {
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        },
      })
    end,
  },

  { "tpope/vim-fugitive" },

  { "ellisonleao/gruvbox.nvim" },
})

------------------------------------------------------------
-- Theme (transparent)
------------------------------------------------------------
vim.o.background = "dark"
require("gruvbox").setup({
  contrast = "hard",
  transparent_mode = true,
})
vim.cmd("colorscheme gruvbox")

vim.cmd([[
  highlight Normal       guibg=none ctermbg=none
  highlight NormalFloat  guibg=none ctermbg=none
  highlight SignColumn   guibg=none ctermbg=none
  highlight EndOfBuffer  guibg=none ctermbg=none
]])

------------------------------------------------------------
-- Treesitter
------------------------------------------------------------
require("nvim-treesitter.configs").setup({
  highlight = { enable = true },
  indent = { enable = true },
  playground = { enable = true },
})

------------------------------------------------------------
-- Nvim-tree
------------------------------------------------------------
require("nvim-tree").setup({
  view = {
    side = "right",
    width = 30,
  },
})

------------------------------------------------------------
-- Lualine (only outside tmux)
------------------------------------------------------------
if not vim.env.TMUX then
  require("lualine").setup({
    options = {
      globalstatus = true,
      section_separators = "",
      component_separators = "",
    },
  })
end

------------------------------------------------------------
-- Keymaps
------------------------------------------------------------
local map = vim.keymap.set

-- Explorer / search
map("n", "<leader>e", ":NvimTreeToggle<CR>", { silent = true })
map("n", "<leader>ff", ":Telescope find_files<CR>", { silent = true })
map("n", "<leader>fg", ":Telescope live_grep<CR>", { silent = true })
map("n", "<leader>fb", ":Telescope buffers<CR>", { silent = true })

-- Treesitter playground
map("n", "<leader>tp", ":TSPlaygroundToggle<CR>", { silent = true })

-- Window navigation
map("n", "<C-h>", "<C-w>h", { silent = true })
map("n", "<C-j>", "<C-w>j", { silent = true })
map("n", "<C-k>", "<C-w>k", { silent = true })
map("n", "<C-l>", "<C-w>l", { silent = true })

-- Reload config
map("n", "<leader><leader>", ":luafile %<CR>", { silent = true })
