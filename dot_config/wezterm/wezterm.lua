--  _       __           __                    
-- | |     / /__  ____  / /____  _________ ___ 
-- | | /| / / _ \/_  / / __/ _ \/ ___/ __ `__ \
-- | |/ |/ /  __/ / /_/ /_/  __/ /  / / / / / /
-- |__/|__/\___/ /___/\__/\___/_/  /_/ /_/ /_/ 

local wezterm = require("wezterm")
local mux = wezterm.mux

local config = {}

function scheme_for_appearance(appearance)
    if appearance:find "Dark" then
        return "Catppuccin Mocha"
    else
        return "Catppuccin Macchiato"
    end
end

-- Use config builder object if possible
if wezterm.config_builder then config = wezterm.config_builder() end

-- maximize window on startup
wezterm.on("gui-startup", function(cmd)
  local tab, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

-- Wezterm settings
config.font = wezterm.font({
    family = "Monaspace Neon",
    weight = "Medium",
    stretch = "Normal",
    style = "Normal",
    harfbuzz_features = { "calt", "liga", "dlig", "ss01", "ss02", "ss03", "ss04", "ss05", "ss06", "ss07", "ss08" },
})
config.font_rules = {
    --
    -- Italic (comments)
    --
    {
        intensity = 'Normal',
        italic = true,
        font = wezterm.font({
            family = "Monaspace Radon",
            weight = "Regular",
            stretch = "Normal",
            style = "Normal",
            harfbuzz_features = { "calt", "liga", "dlig", "ss01", "ss02", "ss03", "ss04", "ss05", "ss06", "ss07", "ss08" },
        })
    },
}
config.color_scheme = scheme_for_appearance(wezterm.gui.get_appearance())
config.hide_tab_bar_if_only_one_tab = true
config.font_size = 15.0
config.line_height = 1.1
config.window_decorations = "RESIZE"

return config
