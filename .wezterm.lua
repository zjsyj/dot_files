local wezterm = require 'wezterm'

-- this table will hold the configuration
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
    config = wezterm.config_builder()
end


-- disable check for update
config.check_for_updates = false

-- this is where user apply config choices
--
config.color_scheme = 'Catppuccin Macchiato'

config.window_background_opacity = 0.9
config.warn_about_missing_glyphs = false

-- cancel windows native headline
config.window_decorations = 'INTEGRATED_BUTTONS | RESIZE'
--[[
config.default_prog = {
    'cmd.exe',
    '/k',
    'C:/Program Files (x86)/Microsoft Visual Studio/2019/Community/VC/Auxiliary/Build/vcvars64.bat',
}
]]

config.default_cwd = 'D:/Training/js_src'

config.launch_menu = {
    {
        label = "CMD",
        args = { "cmd.exe" },
    },
    {
        label = 'X64 build VS',
        args = { 'cmd.exe', '/k', 'C:/Program Files (x86)/Microsoft Visual Studio/2019/Community/VC/Auxiliary/Build/vcvars64.bat' },
    },
    {
        label = 'Git Bash',
        args = { 'E:/Git/bin/bash.exe' },
    },
    { label = 'PowerShell', args = { 'powershell.exe', }, },
}

-- You can specify some parameters to influence the font selection;
-- for example, this selects a Bold, Italic font variant.
config.font = wezterm.font_with_fallback({ 'JetBrains Mono' })
config.window_padding = {
    left = 5,
    right = 5,
    top = 5,
    bottom = 5
}
-- Using shell
-- Title
local function basename(s)
    return string.gsub(s, '(.*[/\\])(.*)', '%2')
end

wezterm.on('format-tab-title', function(tab, tabs)
    local pane = tab.active_pane
    local index = ""

    if #tabs > 1 then
        index = string.format("%d", tab.tab_index + 1)
    end

    local process = basename(pane.foreground_process_name)
    return { {
        Text = ' ' .. index .. process
    } }
end
)

-- init startup
wezterm.on('gui-startup', function(cmd)
    local _, _, window = wezterm.mux.spawn_window(cmd or {})
    window:gui_window():maximize()
end
)

local action = wezterm.action
config.disable_default_key_bindings = true
config.keys = {
    { key = 'Tab',       mods = 'CTRL',       action = action.ActivateTabRelative(1) },
    { key = 'Tab',       mods = 'SHIFT|CTRL', action = action.ActivateTabRelative(-1) },
    { key = 'F11',       mods = 'NONE',       action = action.ToggleFullScreen },
    { key = 'C',         mods = 'SHIFT|CTRL', action = action.CopyTo 'Clipboard' },
    { key = 'N',         mods = 'SHIFT|CTRL', action = action.SpawnWindow },
    { key = 'T',         mods = 'SHIFT|CTRL', action = action.ShowLauncher },
    { key = 'Enter',     mods = 'SHIFT|CTRL', action = action.ShowLauncherArgs { flags = 'FUZZY|LAUNCH_MENU_ITEMS' } },
    { key = 'V',         mods = 'SHIFT|CTRL', action = action.PasteFrom 'Clipboard' },
    { key = 'W',         mods = 'SHIFT|ALT', action = action.CloseCurrentTab { confirm = false } },
    { key = 'PageUp',    mods = 'SHIFT|CTRL', action = action.ScrollByPage(-1) },
    { key = 'PageDown',  mods = 'SHIFT|CTRL', action = action.ScrollByPage(1) },
    { key = 'UpArrow',   mods = 'SHIFT|CTRL', action = action.ScrollByLine(-1) },
    { key = 'DownArrow', mods = 'SHIFT|CTRL', action = action.ScrollByLine(1) },
    { key = 'm',         mods = 'ALT',        action = action.SendString 'cd /d/Training/js_src/cpp_sources/shell_scripts' },
}

return config
