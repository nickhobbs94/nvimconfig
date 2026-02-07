-- Sets up lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "rebelot/kanagawa.nvim",
    config = function()
      vim.cmd.colorscheme("kanagawa-dragon")
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },

        auto_install = true,

        highlight = {
          enable = true
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<Leader>ss",
            node_incremental = "<Leader>si",
            scope_incremental = "<Leader>sc",
            node_decremental = "<Leader>sd",
          },
        },

        -- textobjects config
        textobjects = {
          select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,

            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              -- You can optionally set descriptions to the mappings (used in the desc parameter of
              -- nvim_buf_set_keymap) which plugins like which-key display
              ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
              -- You can also use captures from other query groups like `locals.scm`
              ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
            },
            -- You can choose the select mode (default is charwise 'v')
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * method: eg 'v' or 'o'
            -- and should return the mode ('v', 'V', or '<c-v>') or a table
            -- mapping query_strings to modes.
            selection_modes = {
              ['@parameter.outer'] = 'v', -- charwise
              ['@function.outer'] = 'v', -- linewise
              ['@class.outer'] = '<c-v>', -- blockwise
            },
            -- If you set this to `true` (default is `false`) then any textobject is
            -- extended to include preceding or succeeding whitespace. Succeeding
            -- whitespace has priority in order to act similarly to eg the built-in
            -- `ap`.
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * selection_mode: eg 'v'
            -- and should return true of false
            include_surrounding_whitespace = true,
          },
        },
      })
    end
  },
  { "nvim-treesitter/nvim-treesitter-textobjects" },

  -- fuzzy finder / quick switching to files/tabs/buffers etc
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>f', builtin.find_files, {desc="Find files"})
      vim.keymap.set('n', '<leader>g', builtin.live_grep, {desc="Live grep"})
      vim.keymap.set('n', '<leader>b', builtin.buffers, {desc="Search buffers"})
      vim.keymap.set('n', '<leader>h', builtin.help_tags, {desc="Search help tags"})
    end,
  },

  -- file explorer plugin with <leader>d
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup {
        sync_root_with_cwd = true,
      }
      local api = require("nvim-tree.api")
      vim.keymap.set('n', '<leader>d', api.tree.toggle, {desc="Toggle dir tree"})
    end,
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {},
  },
--  {
--    "renerocksai/telekasten.nvim",
--    dependencies = {'nvim-telescope/telescope.nvim'},
--    init = function()
--      require('telekasten').setup({
--        home = vim.fn.expand("~/Documents/Wiki"), -- Put the name of your notes directory here
--      })
--    end
--  },
  {
    "andrewferrier/wrapping.nvim",
    config = function()
        require("wrapping").setup()
    end
  },
  {
    "williamboman/mason.nvim",
    config = function()
      require('mason').setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require('mason-lspconfig').setup()
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason-lspconfig.nvim", "saghen/blink.cmp" },
    config = function()
      local lspconfig = require('lspconfig')
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      local on_attach = function(_, bufnr)
        local opts = function(desc)
          return { buffer = bufnr, desc = desc }
        end
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts("Go to definition"))
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts("Go to declaration"))
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts("Hover documentation"))
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts("Rename symbol"))
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts("Code action"))
        vim.keymap.set('n', '<leader>u', require('telescope.builtin').lsp_references, opts("LSP references"))
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts("Previous diagnostic"))
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts("Next diagnostic"))
        vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts("Diagnostics to loclist"))
      end

      lspconfig.marksman.setup { on_attach = on_attach, capabilities = capabilities }
      lspconfig.ts_ls.setup { on_attach = on_attach, capabilities = capabilities }
    end,
  },
  {
    "kylechui/nvim-surround",
    tag = "*",
    config = function()
      require("nvim-surround").setup({})
    end,
  },
  -- autocompletion
  {
    "saghen/blink.cmp",
    version = "1.*",
    opts = {
      keymap = { preset = "default" },
      appearance = { nerd_font_variant = "mono" },
      sources = { default = { "lsp", "path", "buffer" } },
    },
  },
})

