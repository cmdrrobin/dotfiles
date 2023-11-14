local wezterm = require 'wezterm'

function scheme_for_appearance(appearance)
    if appearance:find "Dark" then
        return "Catppuccin Mocha"
    else
        return "Catppuccin Macchiato"
    end
end

return {
    font = wezterm.font({
        family = "Monaspace Neon",
        weight = "Medium",
        stretch = "Normal",
        style = "Normal",
        harfbuzz_features = { "calt", "liga", "dlig", "ss01", "ss02", "ss03", "ss04", "ss05", "ss06", "ss07", "ss08" },
    }),
    font_rules = {
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
    },
    color_scheme = scheme_for_appearance(wezterm.gui.get_appearance()),
    hide_tab_bar_if_only_one_tab = true,
    font_size = 15.0,
    line_height = 1.1,
}
