--  _       __           __
-- | |     / /__  ____  / /____  _________ ___
-- | | /| / / _ \/_  / / __/ _ \/ ___/ __ `__ \
-- | |/ |/ /  __/ / /_/ /_/  __/ /  / / / / / /
-- |__/|__/\___/ /___/\__/\___/_/  /_/ /_/ /_/

local wezterm = require('wezterm')

-- maximize window on startup
wezterm.on('gui-startup', function(cmd)
  local _, _, window = wezterm.mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

local config = {}

-- Use config builder object if possible
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- overwrite terminal settings for better support of images in terminal
config.term = 'xterm-kitty'
config.enable_kitty_graphics = true

-- normally prefer Catppuccin Mocha, but use Rose Pine for now...
config.color_scheme = 'rose-pine'

-- My preferred font (with fallback)
config.font = wezterm.font_with_fallback({
  {
    family = 'Monaspace Neon',
    weight = 400,
    stretch = 'Normal',
    style = 'Normal',
    harfbuzz_features = { 'calt', 'liga' },
  },
  {
    family = 'Symbols Nerd Font',
  },
})

-- nice big font size. (or I am getting old...)
config.font_size = 16.5
config.line_height = 1.5
config.underline_position = -5

-- do not show tab bar when single tab is used
config.hide_tab_bar_if_only_one_tab = true
config.adjust_window_size_when_changing_font_size = false
-- disable the title bar but enable the resizable border
config.window_decorations = 'RESIZE'

-- define hyperlink rules
config.hyperlink_rules = {
  -- Compiled-in default. Used if you don't specify any hyperlink_rules.
  {
    regex = '\\b\\w+://[\\w.-]+\\.[a-z]{2,15}\\S*\\b',
    format = '$0',
  },

  -- Make username/project paths clickable. This implies paths like the following are for GitHub.
  -- As long as a full URL hyperlink regex exists above this it should not match a full URL to
  -- GitHub or GitLab / BitBucket (i.e. https://gitlab.com/user/project.git is still a whole clickable URL)
  {
    regex = [[["]?([\w\d]{1}[-\w\d]+)(/){1}([-\w\d\.]+)["]?]],
    format = 'https://www.github.com/$1/$3',
  },
}

return config
