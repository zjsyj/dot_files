return {
    cmd = {vim.fn.stdpath('config') .. '/../lua-language-server-3.7.4-win32-x64/bin/lua-language-server'},
    filetypes = { 'lua' },
    root_markers = {
      '.luarc.json',
      '.luarc.jsonc',
      '.luacheckrc',
      '.stylua.toml',
      'stylua.toml',
      'selene.toml',
      'selene.yml',
      '.git',
    },
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
