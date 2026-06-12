-- If we are running inside WSL, completely skip outputting this engine block
{{ if .is_wsl -}}
-- WSL Instance: WezTerm configurations are handled by the Windows host.
{{ else -}}
-- Linux/macOS Native Instance
local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- Core Window and UI Mechanics
config.automatically_reload_config = true
config.enable_tab_bar = false
config.window_close_confirmation = "NeverPrompt"
config.color_scheme = 'Guezwhoz'
config.audible_bell = "Disabled"
config.harfbuzz_features = { 'calt=0' }

-- Dynamic Profile Injection via Chezmoi Local Data Blocks
config.font = wezterm.font 'JetBrains Mono'
config.font_size = {{ .wezterm_font_size }}

-- Finally, return the verified configuration mapping payload
return config
{{ end -}}
