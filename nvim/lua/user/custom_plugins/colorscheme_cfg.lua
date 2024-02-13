local function cfg()
    vim.cmd.colorscheme "catppuccin-macchiato"
    require('catppuccin').setup({
        integrations = {
            aerial = true,
            lsp_saga = false,
        },
    })
end

local M =
{
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = cfg,
}

return {
    M
}
