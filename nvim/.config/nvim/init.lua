-- Set leader key
vim.g.mapleader = " "

-- Basic settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.termguicolors = true
vim.opt.cursorline = true
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
  { "nvim-tree/nvim-tree.lua",         dependencies = { "nvim-tree/nvim-web-devicons" }},
  -- Status line
  { "nvim-lualine/lualine.nvim",       dependencies = { "nvim-tree/nvim-web-devicons" } },
  -- Fuzzy Finder (Telescope)
  { "nvim-telescope/telescope.nvim",   dependencies = { "nvim-lua/plenary.nvim" } },
  -- Syntax highlighting
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  -- LSP
  { "neovim/nvim-lspconfig" },
  -- Autocompletion
  { "hrsh7th/nvim-cmp",                dependencies = { "hrsh7th/cmp-nvim-lsp" } },
  -- Git integration
  { "tpope/vim-fugitive" },
  -- Themes
  { "folke/tokyonight.nvim" },
  { "ellisonleao/gruvbox.nvim" },
  { "rebelot/kanagawa.nvim" },
  { "hashicorp/sentinel.vim" },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp", -- won't be used w/o LSP but safe to include
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",            -- Snippet engine
      "saadparwaiz1/cmp_luasnip",    -- Snippet source for cmp
      "rafamadriz/friendly-snippets" -- Optional: common snippets
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
})

require("nvim-tree").setup({
    view={
        side = "right",
        width = 30,
    }
})    

-- Theme settings
vim.o.background = "dark"       -- Change to "light" if needed
vim.cmd("colorscheme kanagawa") -- Default theme

-- Gruvbox customization (Optional)
require("gruvbox").setup({
  contrast = "hard", -- Options: "soft", "medium", "hard"
  transparent_mode = true,
})

-- Quick theme switching
vim.keymap.set("n", "<leader>tg", ":colorscheme gruvbox<CR>", { silent = true })    -- Switch to Gruvbox
vim.keymap.set("n", "<leader>tt", ":colorscheme tokyonight<CR>", { silent = true }) -- Switch to Tokyonight

-- Load plugin configs
require("nvim-tree").setup()
require("lualine").setup()

-- Keybindings
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { silent = true })        -- File Explorer
vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", { silent = true }) -- Find files
vim.keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>", { silent = true })  -- Live Grep
vim.keymap.set("n", "<leader>fb", ":Telescope buffers<CR>", { silent = true })    -- Open Buffers

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { silent = true }) -- Move to the left window
vim.keymap.set("n", "<C-j>", "<C-w>j", { silent = true }) -- Move to the window below
vim.keymap.set("n", "<C-k>", "<C-w>k", { silent = true }) -- Move to the window above
vim.keymap.set("n", "<C-l>", "<C-w>l", { silent = true }) -- Move to the right window

-- Tab navigation
vim.keymap.set("n", "<leader>tn", ":tabnew<CR>", { silent = true })      -- Open a new tab
vim.keymap.set("n", "<leader>to", ":tabonly<CR>", { silent = true })     -- Close all other tabs
vim.keymap.set("n", "<leader>tc", ":tabclose<CR>", { silent = true })    -- Close current tab
vim.keymap.set("n", "<leader>tp", ":tabprevious<CR>", { silent = true }) -- Go to previous tab
vim.keymap.set("n", "<leader>tn", ":tabnext<CR>", { silent = true })     -- Go to next tab

vim.keymap.set("n", "<leader><leader>", ":luafile %<CR>", { silent = true })

print("Neovim is ready! 🚀")
