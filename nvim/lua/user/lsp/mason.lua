local servers = {
    "clangd",
    "lua_ls",
    "pylsp",
    "jsonls",
    "rust_analyzer"
}

local settings = {
    ui = {
        border = "none",
        icons = {
            package_installed = "◍",
            package_pending = "◍",
            package_uninstalled = "◍",
        },
    },
    log_level = vim.log.levels.INFO,
    max_concurrent_installers = 4,
}

require("mason").setup(settings)
require("mason-lspconfig").setup({
    ensure_installed = servers,
    automatic_installation = true,
})

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
    return
end

local handler = require("user.lsp.handlers")
local opts = {
    on_attach = handler.on_attach,
    capabilities = handler.capabilities
}

handler.setup()
for _, server in pairs(servers) do
    server = vim.split(server, "@")[1]

    local require_ok, conf_opts = pcall(require, "user.lsp.settings." .. server)
    if require_ok then
        opts = vim.tbl_deep_extend("force", conf_opts, opts)
    end

    lspconfig[server].setup(opts)
end

local flutter_tools_ok, flutter_tools = pcall(require, "flutter-tools")
if flutter_tools_ok then
    flutter_tools.setup {
        ui = {
            -- the border type to use for all floating windows, the same options/formats
            -- used for ":h nvim_open_win" e.g. "single" | "shadow" | {<table-of-eight-chars>}
            border = "rounded",
            -- This determines whether notifications are show with `vim.notify` or with the plugin's custom UI
            -- please note that this option is eventually going to be deprecated and users will need to
            -- depend on plugins like `nvim-notify` instead.
            notification_style = 'plugin'
        },
        fvm = false, -- takes priority over path, uses <workspace>/.fvm/flutter_sdk if enabled
        widget_guides = {
            enabled = false,
        },
        closing_tags = {
            highlight = "ErrorMsg", -- highlight for the closing tag
            prefix = ">",           -- character to use for close tag e.g. > Widget
            enabled = true          -- set to false to disable
        },
        decorations = {
            statusline = {
                -- set to true to be able use the 'flutter_tools_decorations.app_version' in your statusline
                -- this will show the current version of the flutter app from the pubspec.yaml file
                app_version = false,
                -- set to true to be able use the 'flutter_tools_decorations.device' in your statusline
                -- this will show the currently running device if an application was started with a specific
                -- device
                device = false,
                -- set to true to be able use the 'flutter_tools_decorations.project_config' in your statusline
                -- this will show the currently selected project configuration
                project_config = false,
            }
        },
        lsp = {
            color = {
                -- show the derived colours for dart variables
                enabled = false,        -- whether or not to highlight color variables at all, only supported on flutter >= 2.10
                background = false,     -- highlight the background
                background_color = nil, -- required, when background is transparent (i.e. background_color = { r = 19, g = 17, b = 24},)
                foreground = false,     -- highlight the foreground
                virtual_text = true,    -- show the highlight using virtual text
                virtual_text_str = "■", -- the virtual text character to highlight
            },
            on_attach = handler.on_attach,
            capabilities = handler.capabilities,
            settings = {
                showTodos = true,
                completeFunctionCalls = true,
                --                analysisExcludedFolders = { "E:\\flutter" },
                renameFilesWithClasses = "prompt",
                enableSnippets = true,
                updateImportsOnRename = true
            }
        }
    }
end
