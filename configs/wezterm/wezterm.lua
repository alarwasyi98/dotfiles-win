-- WezTerm Configuration
local wezterm = require("wezterm")

-- Custom Configuration table
local config = {}

-- Use the WezTerm config_builder for better error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end
-- Change Default Program on Startup
config.default_prog = { "pwsh.exe", "-NoLogo" } -- Use PowerShell as default shell
config.initial_cols = 125 -- Set initial width to 125 columns
config.initial_rows = 30 -- Set initial height to 30 rows
-- Window Appearance Configuration
config.window_background_opacity = 0.5 -- Background transparency
config.win32_system_backdrop = "Acrylic" -- Windows blur effect
config.color_scheme = "Dracula" -- See the full list https://wezterm.org/colorschemes/index.html
-- Font Configuration
config.font = wezterm.font("FiraCode Nerd Font", { weight = "Bold", italic = false })
config.font_size = 10.0
-- Optional: Specify a custom workspace configuration
config.default_workspace = "default"
-- Remove Unnecessary Elements on Title Bar
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.window_close_confirmation = "NeverPrompt" -- Close without confirmation
-- Cursor configuration (bar cursor)
config.default_cursor_style = "BlinkingBar"
-- Additional optional tweaks
config.adjust_window_size_when_changing_font_size = true
config.enable_tab_bar = true
config.use_fancy_tab_bar = true
-- Finally, return the configuration to wezterm:
return config
