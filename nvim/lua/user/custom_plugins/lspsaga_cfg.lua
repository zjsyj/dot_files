return {
    'nvimdev/lspsaga.nvim',
    config = function()
        -- vim.keymap.set('n', 'K', ':Lspsaga hover_doc<CR>')
        -- <C-f><C-e> to preview code action
        -- vim.keymap.set('n', '[e', ':Lspsaga diagnostic_jump_next<CR>')
        require('lspsaga').setup({
            ui = {
                kind = require("catppuccin.groups.integrations.lsp_saga").custom_kind(),
            },
            symbol_in_winbar = {
                show_file = true,
                folder_level = 0,
            }
        })
    end,
    event = 'LspAttach',
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'nvim-tree/nvim-web-devicons'
    }
}
