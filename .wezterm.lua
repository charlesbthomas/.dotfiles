local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.font = wezterm.font("MesloLGS Nerd Font Mono")
config.font_size = 14
config.window_padding = {
	left = 5,
	right = 5,
	top = 5,
	bottom = 5,
}
config.enable_tab_bar = false
config.color_scheme = "Gruvbox Dark (Gogh)"
--
config.window_background_opacity = 0.75
config.macos_window_background_blur = 10
config.native_macos_fullscreen_mode = true

-- and finally, return the configuration to wezterm
return config
