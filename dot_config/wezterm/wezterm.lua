-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

config = {
	automatically_reload_config = true,
	enable_tab_bar = false,
	window_close_confirmation = "NeverPrompt",
	--window_decorations = "RESIZE",
  color_scheme = 'Guezwhoz',
	font_size = 24,
}

config.harfbuzz_features = { 'calt=0' }

wezterm.on("gui-startup", function(cmd)
	local tab, pane, window = mux.spawn_window(cmd or {})
	window:gui_window():maximize() end)

-- and finally, return the configuration to wezterm
return config
