-- auto install packer if not installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

-- import packer safely
local status, packer = pcall(require, "packer")
if not status then
  return
end

-- add list of plugins to install
return packer.startup(function(use)
  -- packer can manage itself
  use("wbthomason/packer.nvim")
  use("nvim-lua/plenary.nvim") -- lua functions that many plugins use

  -- use("bluz71/vim-nightfly-guicolors") -- preferred colorscheme
  use 'folke/tokyonight.nvim'
  use 'Mofiqul/dracula.nvim'
  use 'catppuccin/nvim'

  use 'xiyaowong/nvim-transparent'
  use {
    "folke/zen-mode.nvim",
    config = function()
      require("zen-mode").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        window = {
          width = 120
        }
      }
    end
  }

  use("christoomey/vim-tmux-navigator") -- tmux & split window navigation

  -- essential plugins
  use("tpope/vim-surround")               -- add, delete, change surroundings (it's awesome)
  use("inkarkat/vim-ReplaceWithRegister") -- replace with register contents using motion (gr + motion)

  -- commenting with gc
  use("numToStr/Comment.nvim")

  -- file explorer
  use("nvim-tree/nvim-tree.lua")
  use {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require('neo-tree').setup({
        popup_border_style = 'rounded',
        sources = {
          "filesystem",
          "buffers",
        },
        filesystem = {
          filtered_items = {
            visible = true,
            hide_gitignored = false,
            hide_hidden = false,
            hide_dotfiles = false,
          },
          follow_current_file = true,
        }
      })
    end
  }

  -- icons
  use("nvim-tree/nvim-web-devicons")

  -- statusline
  use("nvim-lualine/lualine.nvim")

  -- fuzzy finding w/ telescope
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- dependency for better sorting performance
  use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" })        -- fuzzy finder
  use 'ThePrimeagen/harpoon'                                        -- jump to files in a project

  -- autocompletion
  use("hrsh7th/cmp-vsnip")
  use("hrsh7th/vim-vsnip")
  use("hrsh7th/nvim-cmp")      -- completion plugin
  use("hrsh7th/cmp-buffer")    -- source for text in buffer
  use("hrsh7th/cmp-path")      -- source for file system paths
  use("windwp/nvim-autopairs") -- autoclose parens, brackets, quotes, etc...
  use("windwp/nvim-ts-autotag")

  -- lsp server stuff
  use("hrsh7th/cmp-nvim-lsp")
  use({ "glepnir/lspsaga.nvim", branch = "main" }) -- enhanced lsp uis
  use("onsails/lspkind.nvim")                      -- vs-code like icons for autocompletion
  use({
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  })

  -- AI Tools
  use("github/copilot.vim")
  use({
    "piersolenski/wtf.nvim",
    config = function()
      require("wtf").setup()
    end,
    requires = {
      "MunifTanjim/nui.nvim",
    }
  })
  use({
    "jackMort/ChatGPT.nvim",
    config = function()
      require("chatgpt").setup()
    end,
    requires = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    }
  })

  -- use {
  --   'echasnovski/mini.indentscope',
  --   config = function()
  --     require("mini.indentscope").setup({
  --       symbol = "│",
  --       options = { try_as_border = true },
  --     })
  --   end
  -- }
  use({
    "rcarriga/nvim-notify",
    config = function()
      require("notify").setup({
        -- Animation style (see below for details)
        stages = "fade_in_slide_out",

        -- Default timeout for notifications
        timeout = 500,

        -- For stages that change opacity this is treated as the highlight behind the window
        background_colour = "#000000",
        max_height = function()
          return math.floor(vim.o.lines * 0.75)
        end,
        max_width = function()
          return math.floor(vim.o.columns * 0.50)
        end,

        -- Icons for the different levels
        icons = {
          ERROR = "",
          WARN = "",
          INFO = "",
          DEBUG = "",
          TRACE = "✎",
        },
      })
    end
  })

  use({
    "folke/noice.nvim",
    requires = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify"
    },
    config = function()
      require("noice").setup({
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = true,         -- use a classic bottom cmdline for search
          command_palette = true,       -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false,           -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false,       -- add a border to hover docs and signature help
        },
        timeoutlen = 1000,              -- time to wait for a mapping to complete in milliseconds
      })
    end
  })

  -- scala metals
  use({
    'scalameta/nvim-metals',
    requires = {
      "nvim-lua/plenary.nvim",
      "mfussenegger/nvim-dap"
    }
  })
  -- Rust tools
  use 'simrat39/rust-tools.nvim'
  use({ "nvimtools/none-ls.nvim" })

  -- snippets
  use("L3MON4D3/LuaSnip")             -- snippet engine
  use("saadparwaiz1/cmp_luasnip")     -- for autocompletion
  use("rafamadriz/friendly-snippets") -- useful snippets

  -- treesitter configuration
  use({
    "nvim-treesitter/nvim-treesitter",
    run = function()
      local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
      ts_update()
    end,
  })

  -- git
  use("lewis6991/gitsigns.nvim") -- show line modifications on left hand side

  if packer_bootstrap then
    require("packer").sync()
  end
end)
