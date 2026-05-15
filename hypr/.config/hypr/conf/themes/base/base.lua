-- Master Configuration File: ~/.config/hypr/hyprland.lua
-- Hyprland 0.55 Migration

-- Set the package path so Lua knows where to look for your modules
-- This points to your existing theme-based structure
package.path = package.path .. ";" .. os.getenv("HOME") .. "/.config/hypr/?.lua"

-------------------------------------------------------------------------------
-- MODULAR IMPORTS (The "Source" equivalent)
-- Note: Files must end in .lua and use valid Lua syntax
-------------------------------------------------------------------------------
require("conf.themes.base.monitors.default")
require("conf.themes.base.startup.default")
require("conf.themes.base.environment.default")
require("conf.themes.base.permissions.default")
require("conf.themes.base.lookandfeel.default")
require("conf.themes.base.input.default")
require("conf.themes.base.keybindings.default")
require("conf.themes.base.windowrules.default")
require("conf.themes.base.misc.default")

-- Local Relative Imports
require("dms.binds")
require("dms.outputs")
require("dms.cursor")

-------------------------------------------------------------------------------
-- DEBUG SETTINGS
-------------------------------------------------------------------------------
hl.config({
    debug = {
        disable_logs = true,
        gl_debugging = false,
    }
})
