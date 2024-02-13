local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
    return
end

-- local parser_dir = vim.fn.stdpath "data" .. "/parsers"
-- print(parser_dir)

-- vim.opt.runtimepath:append(parser_dir)

configs.setup {
    ensure_installed = {"cpp", "c", "lua", "vim", "rust", "query"},
    sync_install = false,
    ignore_install = { "agda", "dhall", "gitcommit", "haskell", "julia", "tlaplus", "verilog" }, -- List of parsers to ignore installing
    highlight = {
        enable = true,                                                                    -- false will disable the whole extension
        disable = { "" },                                                                 -- list of language that will be disabled
        additional_vim_regex_highlighting = true,

    },
    indent = { enable = true, disable = { "yaml" , "dart"} },
    --
    -- parser_install_dir = parser_dir
}
