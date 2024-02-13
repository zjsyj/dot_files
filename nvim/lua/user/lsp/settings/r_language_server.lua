--[[
local util = require('lspconfig.util')

local function determine_r_root(workspace)
    local root_files = util.root_pattern('.Rproj')(workspace)

    return root_files and #root_files > 0 and vim.fn.fnamemodify(root_files[1]) or util.find_git_ancestor(workspace)
end

return {
    cmd = {
        'R',
        '--arch',
        'x64',
        '--slave',
        '--vanilla',
        '-e',
        'languageserver::run'
    },
    root_dir = function ()
        return vim.loop.cwd()
        
    end,
}
]]
return {
}
