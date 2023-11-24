--  _       __           __                    
-- | |     / /__  ____  / /____  _________ ___ 
-- | | /| / / _ \/_  / / __/ _ \/ ___/ __ `__ \
-- | |/ |/ /  __/ / /_/ /_/  __/ /  / / / / / /
-- |__/|__/\___/ /___/\__/\___/_/  /_/ /_/ /_/ 

local wezterm = require("wezterm")
local mux = wezterm.mux

local config = {}

-- Use config builder object if possible
if wezterm.config_builder then config = wezterm.config_builder() end

-- maximize window on startup
wezterm.on("gui-startup", function(cmd)
  local tab, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

-- Wezterm settings
config.font = wezterm.font_with_fallback({
    {
        family = "JetBrains Mono",
        weight = 600,
    },
    {
        family = "Symbols Nerd Font",
    },
})
config.color_scheme = "Catppuccin Macchiato"
config.hide_tab_bar_if_only_one_tab = true
config.font_size = 15.0
config.line_height = 1.1
config.window_decorations = "RESIZE"

-- Use the defaults as a base
config.hyperlink_rules = {
    -- Compiled-in default. Used if you don't specify any hyperlink_rules.
    {
      regex = "\\b\\w+://[\\w.-]+\\.[a-z]{2,15}\\S*\\b",
      format = "$0",
    },

    -- Make username/project paths clickable. This implies paths like the following are for GitHub.
    -- As long as a full URL hyperlink regex exists above this it should not match a full URL to
    -- GitHub or GitLab / BitBucket (i.e. https://gitlab.com/user/project.git is still a whole clickable URL)
    {
        regex = [[["]?([\w\d]{1}[-\w\d]+)(/){1}([-\w\d\.]+)["]?]],
        format = "https://www.github.com/$1/$3",
    },
}

config.mouse_bindings = {
    -- CTRL-click will open the link under the mouse cursor
    {
        event = {
            Up = { streak = 1, button = 'Left' },
        },
        mods = 'CTRL',
        action = wezterm.action.OpenLinkAtMouseCursor,
    },
}

return config
