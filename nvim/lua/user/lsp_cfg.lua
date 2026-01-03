local M = {}

function M.setup()
    local servers = {
        "lua_ls",
--        "r_language_server",
        "jsonls",
        "rust_analyzer",
        "clangd",
    }

    local handler = require("user.lsp.handlers")
    handler.setup()
    local opts = {
        on_attach = handler.on_attach,
        capabilities = handler.capabilities,
    }

    for _, server in ipairs(servers) do
        server = vim.split(server, "@")[1]

        local settings_ok, conf_opts = pcall(require, "user.lsp.settings." .. server)
        if settings_ok then
 --           print("install config " .. server .. " ok")
            local server_opts = vim.tbl_deep_extend("force", conf_opts, opts)
            vim.lsp.config[server] = server_opts
            vim.lsp.enable(server)
        else
            print('No correct setting for ' .. server)
        end
    end
end

return M
