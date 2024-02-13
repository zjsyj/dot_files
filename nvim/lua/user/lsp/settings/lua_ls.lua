return {
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT"
            },
            hint = {
                enable = true,
            },
            diagnostics = {
                enable = true,
                globals = { "vim" },
            },
            telemetry = {
                enable = false
            },
            workspace = {
                checkThirdParty = false,
                library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.stdpath("config") .. "/lua"] = true,
                    [vim.fn.expand("~/xmake")] = true
                },
            },
        },
    },
}
