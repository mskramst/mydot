local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- Core Window and UI Mechanics
config.automatically_reload_config = true
config.enable_tab_bar = false
config.window_close_confirmation = "NeverPrompt"
config.color_scheme = 'Guezwhoz'
config.audible_bell = "Disabled"
config.harfbuzz_features = { 'calt=0' }

-- Profile Injection (Fonts are overridden dynamically via Chezmoi)
config.font = wezterm.font 'JetBrains Mono'

{{ if .is_wsl -}}
-- WSL Specific Scaling overrides (Letting Windows host manage window specifics)
config.font_size = 10.0
{{ else -}}
-- Native Linux/macOS Display Scale
config.font_size = {{ .wezterm_font_size }}
{{ end -}}

-- Finally, return the verified configuration mapping payload cleanly on all platforms
return config
