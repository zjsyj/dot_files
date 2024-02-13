local function config()
    local xmake = require('xmake')
    xmake.setup {
        compile_command = {
            dir = '.'
        }
    }
    local xmake_component = {
        function()
            local project = require('xmake.project_config').info
            if project.target.tg == "" then
                return ""
            end
            return project.target.tg .. "(" .. project.mode .. ")"
        end,
        cond = function()
            return vim.o.columns > 100
        end,
        on_click = function()
            require("xmake.project_config._menu").init() -- Add the on-click ui
        end,
    }

    require("lualine").setup({
        sections = {
            lualine_c = {
                xmake_component,
            }
        }
    })
end

return {
    {
        'Mythos-404/xmake.nvim',
        lazy = true,
        event = 'BufReadPost xmake.lua',
        config = config,
        dependencies = {
            'MunifTanjim/nui.nvim',
            'nvim-lua/plenary.nvim'
        },
    }
}
