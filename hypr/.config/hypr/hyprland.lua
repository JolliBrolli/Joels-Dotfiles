-- ~/.config/hypr/hyprland.lua
-- Main Entry Point for Hyprland 0.55

-------------------------------------------------------------------------------
-- PATH CONFIGURATION
-------------------------------------------------------------------------------
-- Tells Lua to look for scripts in your hypr folder
package.path = package.path .. ";" .. os.getenv("HOME") .. "/.config/hypr/?.lua"

-------------------------------------------------------------------------------
-- MODULAR IMPORTS (The "Source" equivalent)
-- Note: These assume you renamed your .conf files to .lua
-------------------------------------------------------------------------------
local home = os.getenv("HOME")
require("conf.themes.base.monitors.default")
require("conf.themes.base.startup.default")
require("conf.themes.base.environment.default")
require("conf.themes.base.permissions.default")
require("conf.themes.base.input.default")
require("conf.themes.base.keybindings.default")
require("conf.themes.base.windowrules.default")
require("conf.themes.base.misc.default")

-- dofile(home .. "/.local/share/ambxst/hyprland.lua")

require("conf.themes.base.lookandfeel.default")
-------------------------------------------------------------------------------
-- DEBUG SETTINGS
-------------------------------------------------------------------------------
hl.config({
    debug = {
        disable_logs = true,
        gl_debugging = false,
    }
})
