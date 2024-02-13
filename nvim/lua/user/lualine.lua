local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
    return
end

local hide_in_width = function()
    return vim.fn.winwidth(0) > 80
end

local diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    sections = { "error", "warn" },
    symbols = { error = " ", warn = " " },
    colored = false,
    update_in_insert = false,
    always_visible = true,
}

local diff = {
    "diff",
    colored = false,
    symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
    cond = hide_in_width
}

local mode = {
    "mode",
    fmt = function(str)
        return "-- " .. str .. " --"
    end,
}

local filetype = {
    "filetype",
    icons_enabled = false,
    icon = nil,
}

local branch = {
    "branch",
    icons_enabled = true,
    icon = "",
}

local location = {
    "location",
    padding = 0,
}

-- cool function for progress
local progress = function()
    local current_line = vim.fn.line(".")
    local total_lines = vim.fn.line("$")
    local chars = { "  ", "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
    local line_ratio = current_line / total_lines
    local index = math.ceil(line_ratio * #chars)
    return chars[index]
end

local spaces = function()
    -- return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
    return "spaces: " .. vim.api.nvim_get_option_value("shiftwidth", {buf = 0})
end

local filename = {
    'filename',
    file_status = false,
    newfile_status = false,
    -- 0: Just filename
    -- 1: Relative filename
    -- 2: Absolute path
    -- 3: Absolute path, with tilde as home directory
    -- 4: Filename and parent dir, with tilde as home directory
    path = 0,
}

lualine.setup({
    options = {
        icons_enabled = true,
        theme = "auto",
        -- left means left bottom of current window, so the arrow points to right
        -- right means right bottom of current window, so the arrow points to left
        -- to enter non-ASCII char, use CTRL-V_digit in insert mode
        -- if CTRL_V has alreay been remapped to paste, use CTRL_Q
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = { "dashboard", "NvimTree", "Outline" },
        always_divide_middle = true,
    },
    sections = {
        lualine_a = { branch, diagnostics },
        lualine_b = { mode },
        lualine_c = { },
        -- lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_x = { diff, filename, spaces, "encoding", filetype },
        lualine_y = { location },
        lualine_z = { progress },
    },
    inactive_sections = {
        lualine_a = { filename, 'encoding', filetype },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = { 'location' },
        lualine_z = {},
    },
    tabline = {
    },
    extensions = {},
})
