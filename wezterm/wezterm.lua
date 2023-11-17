local wezterm = require("wezterm")
-- local dracula = require("dracula")
local config = {}

config.font = wezterm.font("JetBrains Mono")
config.font_size = 16
config.window_background_opacity = 0.6
config.text_background_opacity = 0.8
config.hide_tab_bar_if_only_one_tab = true

-- config.color_scheme = "dracula"
-- config.tab_bar_at_bottom = true
-- config.use_fancy_tab_bar = false

return config
