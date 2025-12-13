-- Set leader key
vim.g.mapleader = " "

-- Basic settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.termguicolors = true
vim.opt.cursorline = false
vim.opt.wrap = false

-- Install Lazy.nvim if not present
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins
require("lazy").setup({
  -- File Explorer
  { "nvim-tree/nvim-tree.lua", dependencies = { "nvim-tree/nvim-web-devicons" }},
  -- Status Line
  { "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" }},
  -- Fuzzy Finder
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" }},
  -- Syntax Highlighting & Playground
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  { "nvim-treesitter/playground" },
  -- LSP
  { "neovim/nvim-lspconfig" },
  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets"
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
        sources = cmp.config.sources({
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },
  -- Git Integration
  { "tpope/vim-fugitive" },
  -- Themes
  { "folke/tokyonight.nvim" },
  { "ellisonleao/gruvbox.nvim" },
  { "rebelot/kanagawa.nvim" },
  { "hashicorp/sentinel.vim" },
})

-- Theme setup
vim.o.background = "dark"
vim.cmd("colorscheme gruvbox")

-- Gruvbox theme tweaks
require("gruvbox").setup({
  contrast = "hard",
  transparent_mode = true,
})

-- Treesitter setup
require("nvim-treesitter.configs").setup({
  highlight = { enable = true },
  indent = { enable = true },
  playground = {
    enable = true,
    updatetime = 25,
    persist_queries = false,
  },
})

-- File explorer setup
require("nvim-tree").setup({
  view = {
    side = "right",
    width = 30,
  }
})

vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = "TSPlayground",
  callback = function()
    vim.cmd("wincmd L") -- Move window to the far right
  end,
})



-- Status line
require("lualine").setup()

-- Keybindings

-- File/tree/telescope
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { silent = true })
vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", { silent = true })
vim.keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>", { silent = true })
vim.keymap.set("n", "<leader>fb", ":Telescope buffers<CR>", { silent = true })

-- Tree-sitter playground
vim.keymap.set("n", "<leader>tp", ":TSPlaygroundToggle<CR>", { silent = true, desc = "Toggle TS Playground" })

-- Theme switching
vim.keymap.set("n", "<leader>tg", ":colorscheme gruvbox<CR>", { silent = true })
vim.keymap.set("n", "<leader>tt", ":colorscheme tokyonight<CR>", { silent = true })

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { silent = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { silent = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { silent = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { silent = true })

-- Tab navigation
vim.keymap.set("n", "<leader>tn", ":tabnew<CR>", { silent = true })
vim.keymap.set("n", "<leader>to", ":tabonly<CR>", { silent = true })
vim.keymap.set("n", "<leader>tc", ":tabclose<CR>", { silent = true })
vim.keymap.set("n", "<leader>tp", ":tabprevious<CR>", { silent = true })
vim.keymap.set("n", "<leader>tn", ":tabnext<CR>", { silent = true })

-- Reload current file
vim.keymap.set("n", "<leader><leader>", ":luafile %<CR>", { silent = true })

-- Notify ready
print("Neovim is ready! 🚀")

