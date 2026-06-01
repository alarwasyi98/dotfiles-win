--        .__
-- _____  |  |     WEZTERM SETUP
-- \__  \ |  |     Abdul Hakim (alarwasyi98)
--  / __ \|  |__   https://github.com/alarwasyi98/
-- (____  /____/
--      \/

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
config.initial_cols = 139 -- Set initial width to 125 columns
config.initial_rows = 33 -- Set initial height to 30 rows

-- Window Appearance Configuration
config.window_background_opacity = 0.5 -- Background transparency
config.win32_system_backdrop = "Acrylic" -- Windows blur effect
config.color_scheme = "GruvboxDarkHard" -- See the full list https://wezterm.org/colorschemes/index.html

-- Font Configuration
config.font = wezterm.font("FiraCode Nerd Font", { weight = "Bold", italic = false })
config.font_size = 9.0

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
config.window_padding = {
	left = 8,
	right = 8,
	top = 8,
	bottom = 8,
}

-- Launch Menu Configuration (Multiple Shell Profiles)
config.launch_menu = {
	{
		label = "PowerShell",
		args = { "pwsh.exe", "-NoLogo" },
	},
	{
		label = "Arch Linux",
		args = { "wsl.exe", "-d", "archk" },
		-- Replace "Arch" with your actual WSL distribution name
		-- You can check with: wsl --list --verbose
	},
	{
		label = "Nushell",
		args = { "nu.exe" },
		-- Make sure nu.exe is in your PATH or provide full path like:
		-- args = { "C:\\Users\\YourUsername\\AppData\\Local\\Programs\\nu\\bin\\nu.exe" },
	},
	{
		label = "Command Prompt",
		args = { "cmd.exe" },
	},
}

-- Key Bindings for Quick Profile Access
config.keys = {
	-- Show launch menu with Ctrl+Shift+L
	{
		key = "L",
		mods = "CTRL|SHIFT",
		action = wezterm.action.ShowLauncher,
	},
	-- Quick access to specific profiles
	{
		key = "1",
		mods = "CTRL|ALT",
		action = wezterm.action.SpawnCommandInNewTab({
			args = { "pwsh.exe", "-NoLogo" },
		}),
	},
	{
		key = "2",
		mods = "CTRL|ALT",
		action = wezterm.action.SpawnCommandInNewTab({
			args = { "wsl.exe", "-d", "archlinux" },
		}),
	},
	{
		key = "3",
		mods = "CTRL|ALT",
		action = wezterm.action.SpawnCommandInNewTab({
			args = { "nu.exe" },
		}),
	},
	{
		key = "4",
		mods = "CTRL|ALT",
		action = wezterm.action.SpawnCommandInNewTab({
			args = { "cmd.exe" },
		}),
	},
}

-- GUI Startup Event Handler
wezterm.on("gui-startup", function(cmd)
	local mux = wezterm.mux
	-- Define window position (centered on 1920x1080 monitor)
	-- Adjust these values based on your monitor size and preferences
	local centered_position = {
		x = 320, -- (1920 - ~1280) / 2 for horizontal centering
		y = 180, -- (1080 - ~720) / 2 for vertical centering
		origin = "ScreenCoordinateSystem",
	}
	-- Spawn the main window with specific position
	local tab, pane, window = mux.spawn_window({
		args = cmd and cmd.args or { "pwsh.exe", "-NoLogo" },
		position = centered_position,
		-- Optional: Set working directory
		-- cwd = "C:\\Development",
		-- Optional: Set environment variables
		-- set_environment_variables = {
		--     PROJECT = "MyProject"
		-- }
	})
	-- Optional: Create additional tabs
	-- Uncomment the lines below if you want extra tabs on startup

	-- Tab for system monitoring
	-- window:spawn_tab({
	--     args = { "pwsh.exe", "-NoLogo", "-Command", "Get-Process | Sort-Object CPU -Descending | Select-Object -First 10" }
	-- })

	-- Tab for development directory
	-- window:spawn_tab({
	--     args = { "pwsh.exe", "-NoLogo" },
	--     cwd = "C:\\Development"
	-- })
end)

-- Finally, return the configuration to wezterm:
return config
