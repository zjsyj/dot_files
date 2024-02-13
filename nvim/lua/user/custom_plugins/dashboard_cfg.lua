return {
    {
        'nvimdev/dashboard-nvim',
        cond = firenvim_not_active,
        config = function()
            local status, db = pcall(require, 'dashboard')
            if not status then
                vim.notify('没有找到 dashboard')
                return
            end


            db.setup {
                theme = 'hyper',
                disable_move = false,
                shortup_type = 'letter',
                change_to_vcs_root = false,
                config = {
                    week_header = {
                        enable = true,
                        concat = "I Love You, Juan & Lucas",
                        append = {}
                    },
                    hide = {
                        statusline = true,
                        tablineline = true,
                        winbar = true,
                    },
                    preview = {
                    },
                    shortcut = {
                        { desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
                        { desc = ' Modify Your Neovim Settings', action = 'edit $MYVIMRC', key = 'q' },
                        { desc = ' Useless, For fun', icon_hl = '@variable', group = 'Label', action = '', },
                        { desc = ' Useless, For fun', group = 'DiagnosticHint', action = '' },
                        { desc = ' Useless, For fun', group = 'Number', action = '', },
                    },
                    project = {
                        enable = false,
                    },
                    mru = {
                        limit = 7,
                    },
                    footer = {
                        '',
                        '',
                        'https://zjsyj.github.io/'
                    }
                }
            }
        end,

        dependencies = {
            { 'nvim-tree/nvim-web-devicons' },
        }
    }
}
