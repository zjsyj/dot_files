local M = {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
   -- event = {'LazyFile', 'VeryLazy'},
    event = 'VeryLazy',
    cmd = {'TSInstall', 'TSUpdate', 'TSUpdateSync'},
    config = function()
        local configs = require('nvim-treesitter.configs')
        configs.setup({
            ensure_installed = {
                "cpp",
                "c",
                "lua",
                "vim",
                "vimdoc", "javascript", "html", "rust", "query",
                "markdown",
            },
            sync_install = false,
            ignore_install = { "agda", "dhall", "gitcommit", "haskell", "julia", "tlaplus", "verilog" }, -- List of parsers to ignore installing
            highlight = {
                enable = true,                                                                           -- false will disable the whole extension

            },
            indent = { enable = true, disable = { "yaml", "dart" } },
            --
            -- parser_install_dir = parser_dir
        })
    end
}

return {
    M
}
