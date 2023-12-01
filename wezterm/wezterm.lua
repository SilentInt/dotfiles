local wezterm = require("wezterm")
local dracula = require("dracula")

-- 使用 Dracula 配色方案
return {
	font = wezterm.font_with_fallback({ "FiraCode Nerd Font", "JetBrains Mono", "WenQuanYi Micro Hei" }),
	font_size = 14,
	window_background_opacity = 0.8,
	text_background_opacity = 0.8,
	hide_tab_bar_if_only_one_tab = true,
	colors = dracula,

	tab_bar_at_bottom = true,
	use_fancy_tab_bar = false,
}
