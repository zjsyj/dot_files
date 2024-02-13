local fn = vim.fn

-- Automatically install packer
local lazy_path = fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazy_path) then
    fn.system {
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
	    "--branch=stable",
        lazy_path,
    }
    print "lazy installed"
end

vim.opt.rtp:prepend(lazy_path)

-- Use a protected call so we don't error out on first use
local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
    return
end

lazy.setup("user/custom_plugins", {})
--[[
-- Install your plugins here
return lazy.setup(function(use)
    -- My plugins here
    use "wbthomason/packer.nvim" -- Have packer manage itself
    use "nvim-lua/popup.nvim"    -- An implementation of the Popup API from vim in Neovim
    use "nvim-lua/plenary.nvim"  -- Useful lua functions used by lots of plugins
    -- colorscheme
    use({
        "catppuccin/nvim",
        as = "catppuccin",
        config = function() -- run after this plugin loaded
            vim.cmd.colorscheme("catppuccin-macchiato")
        end,
    })

    --    use({
    --        'glepnir/zephyr-nvim',
    --        requires = { 'nvim-treesitter/nvim-treesitter', opt = true },
    --        config = function()
    --            vim.cmd.colorscheme('zephyr')
    --        end
    --    })
    --    use {
    --        'shaunsingh/nord.nvim',
    --        config = function()
    --            vim.cmd.colorscheme('nord')
    --        end
    --
    --    }
    use 'nvim-tree/nvim-web-devicons'
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true },
        config = function()
            require('lualine').setup {
                options = {
                    fmt = string.lower,
                    theme = 'nord'
                },
            }
        end
    }

    -- cmp plugins
    use "hrsh7th/nvim-cmp"         -- The completion plugin
    use "hrsh7th/cmp-buffer"       -- buffer completions
    use "hrsh7th/cmp-path"         -- path completions
    use "hrsh7th/cmp-cmdline"      -- cmdline completions
    use "hrsh7th/cmp-nvim-lsp-signature-help"
    use "saadparwaiz1/cmp_luasnip" -- snippet completions
    use "hrsh7th/cmp-nvim-lsp"
    use "windwp/nvim-autopairs"    -- Autopairs, integrates with both cmp and treesitter

    -- snippets
    use "L3MON4D3/LuaSnip"             --snippet engine
    use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

    -- LSP
    use "neovim/nvim-lspconfig"
    use "williamboman/mason.nvim"
    use "williamboman/mason-lspconfig.nvim"
    use "jose-elias-alvarez/null-ls.nvim"

    use "stevearc/dressing.nvim"
    use {
        'akinsho/flutter-tools.nvim',
        requires = { 'nvim-lua/plenary.nvim', 'stevearc/dressing.nvim' },
    }

    -- Telescope
    use "nvim-telescope/telescope.nvim"

    -- Treesitter
    use {
        "nvim-treesitter/nvim-treesitter",
        -- run = ':TSUpdate' will cause Packer to fail upon the first installation
        run = function()
            local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
            ts_update()
        end
    }

    --    use {
    --        'simrat39/symbols-outline.nvim',
    --
    --        config = function()
    --            require('symbols-outline').setup()
    --        end
    --    }
    use {
        'stevearc/aerial.nvim',
    }


    -- markdown preview
    -- use "ellisonleao/glow.nvim"
    use 'lewis6991/gitsigns.nvim'

    use 'nvim-tree/nvim-tree.lua'

    -- DAP
    -- use 'mfussenegger/nvim-dap'

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
]]
