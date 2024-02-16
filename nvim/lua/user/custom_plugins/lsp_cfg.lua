local cfg = function()
    local ok, lsp_cfg = pcall(require, 'lspconfig')
    if not ok then
        return
    end

    local servers = {
        "lua_ls",
        "r_language_server",
        "jsonls",
        "rust_analyzer",
        "clangd",
    }

    local handler = require("user.lsp.handlers")
    local opts = {
        on_attach = handler.on_attach,
        capabilities = handler.capabilities,
    }

    handler.setup()
    for _, server in ipairs(servers) do
        server = vim.split(server, "@")[1]

        local settings_ok, conf_opts = pcall(require, "user.lsp.settings." .. server)
        if settings_ok then
--            print("install config " .. server .. " ok")
            local server_opts = vim.tbl_deep_extend("force", opts, conf_opts)
            lsp_cfg[server].setup(server_opts)
        else
            print('No correct setting for ' .. server)
        end
    end
end

return {
    {
        "neovim/nvim-lspconfig",
        event = {'BufRead', 'BufNewFile'},
        config = cfg,
    }
}
