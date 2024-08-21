local wezterm = require("wezterm")
local mux = wezterm.mux
local act = wezterm.action
local config = {}
local keys = {}
local mouse_bindings = {}
local launch_menu = {}
local haswork, work = pcall(require, "work")

--- Setup PowerShell options
if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	--- Grab the ver info for later use.
	local success, stdout, stderr = wezterm.run_child_process({ "cmd.exe", "ver" })
	local major, minor, build, rev = stdout:match("Version ([0-9]+)%.([0-9]+)%.([0-9]+)%.([0-9]+)")
	local is_windows_11 = tonumber(build) >= 22000

	--- Make it look cool.
	if is_windows_11 then
		wezterm.log_info("We're running Windows 11!")
	end

	--- Set Pwsh as the default on Windows
	config.default_prog = { "pwsh.exe", "-NoLogo" }
	table.insert(launch_menu, {
		label = "Pwsh",
		args = { "pwsh.exe", "-NoLogo" },
	})
	table.insert(launch_menu, {
		label = "PowerShell",
		args = { "powershell.exe", "-NoLogo" },
	})
	table.insert(launch_menu, {
		label = "Pwsh No Profile",
		args = { "pwsh.exe", "-NoLogo", "-NoProfile" },
	})
	table.insert(launch_menu, {
		label = "PowerShell No Profile",
		args = { "powershell.exe", "-NoLogo", "-NoProfile" },
	})
else
	--- Non-Windows Machine
	table.insert(launch_menu, {
		label = "Pwsh",
		args = { "/usr/local/bin/pwsh", "-NoLogo" },
	})
	table.insert(launch_menu, {
		label = "Pwsh No Profile",
		args = { "/usr/local/bin/pwsh", "-NoLogo", "-NoProfile" },
	})
end

--- Disable defaul keys and set some minimum ones for now.
--- This helps with conflicting keys in pwsh
keys = {
	{ key = "Tab", mods = "CTRL", action = act.ActivateTabRelative(1) },
	{ key = "Tab", mods = "SHIFT|CTRL", action = act.ActivateTabRelative(-1) },
	{ key = "Enter", mods = "ALT", action = act.ToggleFullScreen },
	{ key = "+", mods = "CTRL", action = act.IncreaseFontSize },
	{ key = "+", mods = "SHIFT|CTRL", action = act.IncreaseFontSize },
	{ key = "-", mods = "CTRL", action = act.DecreaseFontSize },
	{ key = "-", mods = "SHIFT|CTRL", action = act.DecreaseFontSize },
	{ key = "-", mods = "SUPER", action = act.DecreaseFontSize },
	{ key = "0", mods = "CTRL", action = act.ResetFontSize },
	{ key = "0", mods = "SHIFT|CTRL", action = act.ResetFontSize },
	{ key = "0", mods = "SUPER", action = act.ResetFontSize },
	-- I use Ctrl + Number in all my other apps.
	-- I also never have more the 5 tabs
	{ key = "1", mods = "CTRL", action = act.ActivateTab(0) },
	{ key = "2", mods = "CTRL", action = act.ActivateTab(1) },
	{ key = "3", mods = "CTRL", action = act.ActivateTab(2) },
	{ key = "4", mods = "CTRL", action = act.ActivateTab(3) },
	{ key = "5", mods = "CTRL", action = act.ActivateTab(4) },
	{ key = "N", mods = "CTRL", action = act.SpawnTab("CurrentPaneDomain") },
	{ key = "-", mods = "ALT", action = act({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
	{ key = "=", mods = "ALT", action = act({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) },
	{ key = "P", mods = "CTRL", action = act.ActivateCommandPalette },
	{ key = "R", mods = "CTRL", action = act.ReloadConfiguration },
	{ key = "R", mods = "SHIFT|CTRL", action = act.ReloadConfiguration },
	{ key = "T", mods = "CTRL", action = act.ShowLauncher },
	{ key = "T", mods = "SHIFT|CTRL", action = act.ShowLauncher },
	{
		key = "U",
		mods = "CTRL",
		action = act.CharSelect({ copy_on_select = true, copy_to = "ClipboardAndPrimarySelection" }),
	},
	{
		key = "U",
		mods = "SHIFT|CTRL",
		action = act.CharSelect({ copy_on_select = true, copy_to = "ClipboardAndPrimarySelection" }),
	},
	{ key = "V", mods = "CTRL", action = act.PasteFrom("Clipboard") },
	{ key = "W", mods = "CTRL", action = act.CloseCurrentTab({ confirm = true }) },
	{ key = "W", mods = "SHIFT|CTRL", action = act.CloseCurrentTab({ confirm = true }) },
	{ key = "X", mods = "CTRL", action = act.ActivateCopyMode },
	{ key = "X", mods = "SHIFT|CTRL", action = act.ActivateCopyMode },
	{ key = "Z", mods = "CTRL", action = act.TogglePaneZoomState },
	{ key = "Z", mods = "SHIFT|CTRL", action = act.TogglePaneZoomState },
	{ key = "[", mods = "SHIFT|SUPER", action = act.ActivateTabRelative(-1) },
	{ key = "]", mods = "SHIFT|SUPER", action = act.ActivateTabRelative(1) },
	{ key = "^", mods = "CTRL", action = act.ActivateTab(5) },
	{ key = "^", mods = "SHIFT|CTRL", action = act.ActivateTab(5) },
	{ key = "_", mods = "CTRL", action = act.DecreaseFontSize },
	{ key = "_", mods = "SHIFT|CTRL", action = act.DecreaseFontSize },
	{ key = "c", mods = "SHIFT|CTRL", action = act.CopyTo("Clipboard") },
	{ key = "c", mods = "SUPER", action = act.CopyTo("Clipboard") },
	{ key = "f", mods = "SHIFT|CTRL", action = act.Search("CurrentSelectionOrEmptyString") },
	{ key = "f", mods = "SUPER", action = act.Search("CurrentSelectionOrEmptyString") },
	{ key = "k", mods = "SHIFT|CTRL", action = act.ClearScrollback("ScrollbackOnly") },
	{ key = "k", mods = "SUPER", action = act.ClearScrollback("ScrollbackOnly") },
	{ key = "w", mods = "SHIFT|CTRL", action = act.CloseCurrentTab({ confirm = true }) },
	{ key = "w", mods = "SUPER", action = act.CloseCurrentTab({ confirm = true }) },
	{
		key = "R",
		mods = "ALT",
		action = act.PromptInputLine({
			description = "Enter new name for tab",
			action = wezterm.action_callback(function(window, _, line)
				-- line will be `nil` if they hit escape without entering anything
				-- An empty string if they just hit enter
				-- Or the actual line of text they wrote
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},
	{
		key = "LeftArrow",
		mods = "CTRL|SHIFT",
		action = act.ActivatePaneDirection("Left"),
	},
	{
		key = "RightArrow",
		mods = "CTRL|SHIFT",
		action = act.ActivatePaneDirection("Right"),
	},
	{
		key = "UpArrow",
		mods = "CTRL|SHIFT",
		action = act.ActivatePaneDirection("Up"),
	},
	{
		key = "DownArrow",
		mods = "CTRL|SHIFT",
		action = act.ActivatePaneDirection("Down"),
	},
	{
		key = "F",
		mods = "ALT",
		action = wezterm.action.ToggleFullScreen,
	},
	{
		key = "X",
		mods = "CTRL",
		action = wezterm.action.TogglePaneZoomState,
	},
}

-- Mousing bindings
mouse_bindings = {
	-- Change the default click behavior so that it only selects
	-- text and doesn't open hyperlinks
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "NONE",
		action = act.CompleteSelection("ClipboardAndPrimarySelection"),
	},

	-- and make CTRL-Click open hyperlinks
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "CTRL",
		action = act.OpenLinkAtMouseCursor,
	},
	{
		event = { Down = { streak = 3, button = "Left" } },
		action = wezterm.action.SelectTextAtMouseCursor("SemanticZone"),
		mods = "NONE",
	},
}

--- Default config settings
config.scrollback_lines = 7000
config.hyperlink_rules = wezterm.default_hyperlink_rules()
config.hide_tab_bar_if_only_one_tab = true
config.color_scheme = "Flexoki Dark"
config.enable_kitty_graphics = true

--- config.color_scheme = 'AdventureTime'
config.font = wezterm.font_with_fallback({
	{
		family = "FiraCode Nerd Font Mono",
	},
})
config.font_size = 12
config.launch_menu = launch_menu
config.default_cursor_style = "BlinkingBar"
config.disable_default_key_bindings = true
config.keys = keys
config.mouse_bindings = mouse_bindings

-- Allow overwriting for work stuff
if haswork then
	work.apply_to_config(config)
end

return config
