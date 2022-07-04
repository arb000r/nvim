local utils = require("utils")
local fn = vim.fn

vim.g.package_home = fn.stdpath("data") .. "/site/pack/packer/"
local packer_install_dir = vim.g.package_home .. "/opt/packer.nvim"

local packer_repo = "https://github.com/wbthomason/packer.nvim"
local install_cmd = string.format("10split |term git clone --depth=1 %s %s", packer_repo, packer_install_dir)

-- Auto-install packer in case it hasn't been installed.
if fn.glob(packer_install_dir) == "" then
  vim.api.nvim_echo({ { "Installing packer.nvim", "Type" } }, true, {})
  vim.cmd(install_cmd)
end

-- Load packer.nvim
vim.cmd("packadd packer.nvim")
local util = require('packer.util')

require("packer").startup({
  function(use)
    -- it is recommened to put impatient.nvim before any other plugins
    use {'lewis6991/impatient.nvim', config = [[require('impatient')]]}

    use {'neoclide/coc.nvim', branch = 'release'}
    
    -- need this for packer to not be uninstalled
    use({"wbthomason/packer.nvim", opt = true})

    -- theme things
    use 'Mofiqul/dracula.nvim'

    use {'kyazdani42/nvim-web-devicons', event = 'VimEnter'}

    -- fancy start screen
    use {
      'goolord/alpha-nvim',
      requires = { 'kyazdani42/nvim-web-devicons' },
      event = 'VimEnter',
      config = function ()
          require'alpha'.setup(require'alpha.themes.startify'.config)
      end
    }

    -- file explorer
    use {
      'kyazdani42/nvim-tree.lua',
      requires = { 'kyazdani42/nvim-web-devicons' },
      config = [[require('config.nvim-tree')]]
    }

    -- autocomplete
    use({"onsails/lspkind-nvim", event = "VimEnter"})
    use {"hrsh7th/nvim-cmp", after = "lspkind-nvim", config = [[require('config.nvim-cmp')]]}
    use {"hrsh7th/cmp-path", after = "nvim-cmp"}
    use {"hrsh7th/cmp-buffer", after = "nvim-cmp"}
    use { "hrsh7th/cmp-omni", after = "nvim-cmp" }

    -- nvim-lsp configuration (it relies on cmp-nvim-lsp, so it should be loaded after cmp-nvim-lsp).
    use({ "neovim/nvim-lspconfig", after = "cmp-nvim-lsp", config = [[require('config.lsp')]] })

    -- syntax highlighting
    use({ "nvim-treesitter/nvim-treesitter", event = 'BufEnter', run = ":TSUpdate", config = [[require('config.treesitter')]] })

    -- arg swapping
    use({"machakann/vim-swap", event = "VimEnter"})

    -- Super fast buffer jump
    use {
      'phaazon/hop.nvim',
      event = "VimEnter",
      config = function()
        vim.defer_fn(function() require('config.nvim_hop') end, 2000)
      end
    }

    -- Clear highlight search automatically for you
    use({"romainl/vim-cool", event = "VimEnter"})

    -- Show match number and index for searching
    use {
      'kevinhwang91/nvim-hlslens',
      branch = 'main',
      keys = {{'n', '*'}, {'n', '#'}, {'n', 'n'}, {'n', 'N'}},
      config = [[require('config.hlslens')]]
    }

    use({"haya14busa/vim-asterisk", event = 'VimEnter'})

    -- fzf
    use {
      'nvim-telescope/telescope.nvim', cmd = 'Telescope',
      requires = { {'nvim-lua/plenary.nvim'} }
    }
    -- search emoji and other symbols
    use {'nvim-telescope/telescope-symbols.nvim', after = 'telescope.nvim'}

    -- git signals in the left column
    use({"mhinz/vim-signify", event = 'BufEnter'})

    use {
      'nvim-lualine/lualine.nvim',
      event = 'VimEnter',
      config = [[require('config.statusline')]]
    }

    use({
      'noib3/nvim-cokeline',
      requires = 'kyazdani42/nvim-web-devicons', -- If you want devicons
      config = [[require('config.statusline')]]
    })

    use({
      "lukas-reineke/indent-blankline.nvim",
      event = 'VimEnter',
      config = [[require('config.indent-blankline')]]
    })

    use({"tpope/vim-commentary", event = "VimEnter"})

    use({ "jdhao/better-escape.vim", event = { "InsertEnter" } })

    use({ "sbdchd/neoformat", cmd = { "Neoformat" } })

    use({ "tpope/vim-fugitive", event = "User InGitRepo" })
    
    use({ "rbong/vim-flog", requires = "tpope/vim-fugitive", cmd = { "Flog" } })

    use({ "christoomey/vim-conflicted", requires = "tpope/vim-fugitive", cmd = {"Conflicted"}})

    -- Better git commit experience
    use({"rhysd/committia.vim", opt = true, setup = [[vim.cmd('packadd committia.vim')]]})

    -- Markdown JSON header highlight plugin
    use({ "elzr/vim-json", ft = { "json", "markdown" } })

    -- Modern matchit implementation
    use({"andymass/vim-matchup", event = "VimEnter"})

    use({
      "karb94/neoscroll.nvim",
      event = "VimEnter",
      config = function()
        vim.defer_fn(function() require('config.neoscroll') end, 2000)
      end
    })

    use({ "cespare/vim-toml", ft = { "toml" }, branch = "main" })

    use({"gelguy/wilder.nvim", opt = true, setup = [[vim.cmd('packadd wilder.nvim')]]})

    -- show and trim trailing whitespaces
    use {'jdhao/whitespace.nvim', event = 'VimEnter'}
  end,
  config = {
    max_jobs = 16,
    compile_path = util.join_paths(fn.stdpath('data'), 'site', 'lua', 'packer_compiled.lua'),
  },
})

local status, _ = pcall(require, 'packer_compiled')
if not status then
  vim.notify("Error requiring packer_compiled.lua: run PackerSync to fix!")
end
