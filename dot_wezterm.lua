local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

wezterm.font("HackGen35 Console NF", { weight = "Regular", stretch = "Normal", style = "Normal" })
config.font_size = 16
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }

config.color_scheme = "nightfox"
-- config.color_scheme = "nordfox"
-- config.color_scheme = 'Tokyo Night'
-- config.color_scheme = 'Tokyo Night Storm'

config.hide_tab_bar_if_only_one_tab = true

config.initial_rows = 32
config.initial_cols = 98

-- config.audible_bell = 'Disabled'

config.keys = {
	{
		key = "d",
		mods = "CMD",
		action = wezterm.action.SplitHorizontal,
	},
	{
		key = "d",
		mods = "CMD|SHIFT",
		action = wezterm.action.SplitVertical,
	},
	{
		key = "h",
		mods = "CMD",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		key = "l",
		mods = "CMD",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},
	{
		key = "k",
		mods = "CMD",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	{
		key = "j",
		mods = "CMD",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},
	{
		key = "h",
		mods = "CMD|SHIFT",
		action = wezterm.action.AdjustPaneSize({ "Left", 5 }),
	},
	{
		key = "l",
		mods = "CMD|SHIFT",
		action = wezterm.action.AdjustPaneSize({ "Right", 5 }),
	},
	{
		key = "k",
		mods = "CMD|SHIFT",
		action = wezterm.action.AdjustPaneSize({ "Up", 5 }),
	},
	{
		key = "j",
		mods = "CMD|SHIFT",
		action = wezterm.action.AdjustPaneSize({ "Down", 5 }),
	},
}

return config
