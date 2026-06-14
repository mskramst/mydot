local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- Core Window and UI Mechanics
config.automatically_reload_config = true
config.enable_tab_bar = false
config.window_close_confirmation = "NeverPrompt"
config.color_scheme = 'Guezwhoz'
config.audible_bell = "Disabled"
config.harfbuzz_features = { 'calt=0' }
config.font = wezterm.font 'JetBrains Mono'

-- -------------------------------------------------------------
-- Dynamic Environment Detection (Pure Lua)
-- -------------------------------------------------------------
local function is_wsl()
  -- Check if the Linux kernel release contains the word "Microsoft"
  local f = io.open("/proc/version", "r")
  if f then
    local content = f:read("*all")
    f:close()
    if string.find(string.lower(content), "microsoft") then
      return true
    end
  end
  return false
end

-- Set font size depending on the hosting layout
if is_wsl() then
  config.font_size = 10.0
else
  -- Fallback size for native Linux VMs or Mac environments
  config.font_size = 13.0
end

-- Finally, return the verified configuration mapping payload cleanly
return config
