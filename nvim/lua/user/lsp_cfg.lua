local M = {}

local function setup_diagnostics()
    -- Diagnostics {{{
    local config = {
        signs = {
            text = {
                [vim.diagnostic.severity.ERROR] = "",
                [vim.diagnostic.severity.WARN] = "",
                [vim.diagnostic.severity.HINT] = "",
                [vim.diagnostic.severity.INFO] = "",
            },
        },
        update_in_insert = true,
        underline = true,
        severity_sort = true,
        float = {
            focusable = false,
            style = "minimal",
            border = "rounded",
            source = "always",
            header = "",
            prefix = "",
            suffix = "",
        },
    }
    vim.diagnostic.config(config)
    -- }}}

    -- Improve LSPs UI {{{
    local icons = {
        Class = " ",
        Color = " ",
        Constant = " ",
        Constructor = " ",
        Enum = " ",
        EnumMember = " ",
        Event = " ",
        Field = " ",
        File = " ",
        Folder = " ",
        Function = "󰊕 ",
        Interface = " ",
        Keyword = " ",
        Method = "ƒ ",
        Module = "󰏗 ",
        Property = " ",
        Snippet = " ",
        Struct = " ",
        Text = " ",
        Unit = " ",
        Value = " ",
        Variable = " ",
    }

    local completion_kinds = vim.lsp.protocol.CompletionItemKind
    for i, kind in ipairs(completion_kinds) do
        completion_kinds[i] = icons[kind] and icons[kind] .. kind or kind
    end
    -- }}}
end

local function setup_keymap()
    -- Lsp capabilities and on_attach {{{
    -- Here we grab default Neovim capabilities and extend them with ones we want on top
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    capabilities.textDocument.foldingRange = {
        dynamicRegistration = true,
        lineFoldingOnly = true,
    }

    capabilities.textDocument.semanticTokens.multilineTokenSupport = true
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    vim.lsp.config("*", {
        capabilities = capabilities,
        on_attach = function(client, bufnr)
            local ok, diag = pcall(require, "user.workspace-diagnostic")
            if ok then
                diag.populate_workspace_diagnostics(client, bufnr)
            end
        end,
    })
    -- }}}

    -- Disable the default keybinds {{{
    for _, bind in ipairs({ "grn", "gra", "gri", "grr", "grt" }) do
        pcall(vim.keymap.del, "n", bind)
    end
    -- }}}

    -- Create keybindings, commands, inlay hints and autocommands on LSP attach {{{
    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(ev)
            local bufnr = ev.buf
            local client = vim.lsp.get_client_by_id(ev.data.client_id)
            if not client then
                return
            end
            ---@diagnostic disable-next-line need-check-nil
            if client.server_capabilities.completionProvider then
                vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
                -- vim.bo[bufnr].omnifunc = "v:lua.MiniCompletion.completefunc_lsp"
            end
            ---@diagnostic disable-next-line need-check-nil
            if client.server_capabilities.definitionProvider then
                vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
            end

            -- -- nightly has inbuilt completions, this can replace all completion plugins
            -- if client:supports_method("textDocument/completion", bufnr) then
            --   -- Enable auto-completion
            --   vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
            -- end

            --- Disable semantic tokens
            ---@diagnostic disable-next-line need-check-nil
            client.server_capabilities.semanticTokensProvider = nil

            -- All the keymaps
            -- grn, rename
            -- <C-S>, signature_help
            -- gO, document_symbol
            -- ]d, diagnostic next
            -- [d, diagnostic prev
            -- ]D, diagnostic last
            -- [D, diagnostic first
            -- <C-W>d, diagnostic open
            -- [q, quickfix next
            -- ]q, quickfix prev
            -- [a, argument list next
            -- ]a, argument list prev
            local opts = { noremap = true, silent = true }
            vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
            vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
            vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
            vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
            vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
            vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
            vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<CR>", opts)
            vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
            vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wx', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>',
                opts)
            vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
            vim.cmd [[ command! Format execute 'lua vim.lsp.buf.format()' ]]

            -- diagnostic mappings
            vim.api.nvim_buf_set_keymap(bufnr, "n", "<Leader>dv",
                "<cmd>lua vim.diagnostic.config({virtual_lines = not vim.diagnostic.config().virtual_lines})<CR>", opts)
        end,
    })
    -- }}}
end

function M.setup()
    local servers = {
        "lua_ls",
        --        "r_language_server",
        --        "jsonls",
        "rust_analyzer",
        "ty",
        "ruff"
    }

    for _, key in ipairs(servers) do
        vim.lsp.enable(key, true)
    end

    setup_diagnostics()

    setup_keymap()
end

return M
