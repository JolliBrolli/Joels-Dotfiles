local mainMod = "SUPER"
local ipc = "qs -c noctalia-shell ipc call"

-- Application Variables
local terminal = "foot"
local fileManager = "nautilus"
local browser = "~/.local/bin/run_browser.sh"
local ImageViewer = "gwenview"
local MusicPlayer = "~/.local/bin/run_music_app.sh"
local AiAssistant = "~/.local/bin/run_ai_assistant.sh"
local GoogleMeet = "~/.local/bin/launch_google-meet.sh"
local NoteTaker = "obsidian"

--------------------------------------------------------------------------------
-- WINDOW MANAGEMENT & CORE APPS
--------------------------------------------------------------------------------
hl.bind("SUPER + Q", hl.dsp.exec_cmd(terminal))
hl.bind("SUPER + E", hl.dsp.exec_cmd(fileManager))
hl.bind("SUPER + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + ALT + CTRL + C", hl.dsp.window.kill())
hl.bind("SUPER + C", hl.dsp.window.close())
-- hl.bind("SUPER + P", hl.dsp.pseudo())
hl.bind("SUPER + SHIFT + J", hl.dsp.layout("togglesplit"))
hl.bind("SUPER + SHIFT + K", hl.dsp.layout("swapsplit"))
hl.bind("SUPER + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }))

-- App Shortcuts
hl.bind("SUPER + SHIFT + B", hl.dsp.exec_cmd(browser))
hl.bind("SUPER + SHIFT + I", hl.dsp.exec_cmd(ImageViewer))
hl.bind("SUPER + SHIFT + S", hl.dsp.exec_cmd(MusicPlayer))
hl.bind("SUPER + SHIFT + O", hl.dsp.exec_cmd(NoteTaker))
hl.bind("SUPER + SHIFT + Y", hl.dsp.exec_cmd("youtube"))
hl.bind("SUPER + SHIFT + C", hl.dsp.exec_cmd("~/.local/bin/run_canva.sh"))
hl.bind("SUPER + CTRL + W", hl.dsp.exec_cmd("whatsapp-linux-desktop"))
hl.bind("SUPER + SHIFT + CTRL + S", hl.dsp.exec_cmd("~/.local/bin/run_snapchat.sh"))

hl.bind("SUPER + SHIFT + code:201", hl.dsp.exec_cmd(AiAssistant))
hl.bind("SUPER + ALT + F", hl.dsp.exec_cmd("~/.local/bin/sync-asus"))

hl.bind("SUPER + ALT + period", hl.dsp.exec_cmd("~/.local/bin/zen-gesture-toggle.sh"))
--------------------------------------------------------------------------------
-- NAVIGATION & WORKSPACES
--------------------------------------------------------------------------------
-- Vim-style focus
local dirs = { H = "left", J = "down", K = "up", L = "right" }
for key, dir in pairs(dirs) do
  hl.bind("SUPER + " .. key, hl.dsp.focus({ direction = dir }))
end

-- -- Arrow key resizing (active window)
hl.bind("SUPER + right", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })
hl.bind("SUPER + left", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
hl.bind("SUPER + up", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })
hl.bind("SUPER + down", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })
--
-- Workspaces 1-10
for i = 1, 10 do
  local key = tostring(i % 10)
  hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
  hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Special Workspace (Scratchpad)
-- hl.bind("SUPER + ALT + S", hl.dsp.special_workspace({ action = "toggle", name = "magic" }))

--------------------------------------------------------------------------------
-- SYSTEM UTILITIES & HARDWARE
--------------------------------------------------------------------------------
-- Audio & Brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set 5%+"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"))

-- Media Controls
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))

-- Screen Capture
hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot -m output -o ~/Pictures/screenshots/"))
hl.bind("SUPER + PRINT", hl.dsp.exec_cmd("hyprshot -m window -o ~/Pictures/Screenshots/"))
hl.bind("SUPER + SHIFT + PRINT", hl.dsp.exec_cmd("hyprshot -m region -o ~/Pictures/Screenshots/"))

-- Recording
hl.bind("SUPER + R", hl.dsp.exec_cmd("~/.local/bin/record_screen.zsh toggle"))
hl.bind("SUPER + SHIFT + R", hl.dsp.exec_cmd("~/.local/bin/recording/record_screen.zsh area"))
hl.bind("SUPER + ALT + R", hl.dsp.exec_cmd("~/.local/bin/record_screen.zsh stop"))

-- Shell & Power
hl.bind("SUPER + space", hl.dsp.exec_cmd("caelestia shell drawers toggle launcher"))
hl.bind("SUPER + comma", hl.dsp.exec_cmd("caelestia shell controlCenter open"))
hl.bind("SUPER + ALT + Q", hl.dsp.exec_cmd("caelestia shell drawers toggle session"))
hl.bind("SUPER + ALT + L", hl.dsp.exec_cmd("ambxst lock"))
-- hl.bind("SUPER + ALT + B", hl.dsp.exec_cmd("~/.local/bin/launch_waybar.sh"))
hl.bind("SUPER + CTRL + ALT + W", hl.dsp.exec_cmd(ipc .. ' wallpaper random ""'))
hl.bind("SUPER + ALT + W", hl.dsp.exec_cmd(ipc .. " wallpaper toggle"))

-- Opacity & Monitor Power
hl.bind("SUPER + O",
  hl.dsp.exec_cmd(
  'hyprctl getoption decoration:inactive_opacity | grep -q "float: 1.0" && hyprctl keyword decoration:inactive_opacity 0.6 || hyprctl keyword decoration:inactive_opacity 1.0'))
hl.bind("SUPER + ALT + Z", hl.dsp.dpms("off", "eDP-1"))
hl.bind("SUPER + ALT + X", hl.dsp.dpms("on", "eDP-1"))

--------------------------------------------------------------------------------
-- MOUSE & SUBMAPS
--------------------------------------------------------------------------------
-- Mouse Window Management
-- ~/.config/hypr/conf/themes/base/keybindings/default.lua

-- Move window with SUPER + Left Click
hl.bind("SUPER + mouse:272", hl.dsp.window.drag())

-- Resize window with SUPER + Right Click
hl.bind("SUPER + mouse:273", hl.dsp.window.resize())

-- Mail Submap
hl.bind("SUPER + M", hl.dsp.submap("mail"))
hl.define_submap("mail", function()
  hl.bind("P", function()
    hl.dsp.exec_cmd("~/.local/bin/personal_mail.sh"); hl.dsp.submap("reset")
  end)
  hl.bind("W", function()
    hl.dsp.exec_cmd("~/.local/bin/work_mail.sh"); hl.dsp.submap("reset")
  end)
  hl.bind("M", function()
    hl.dsp.exec_cmd("~/.local/bin/mail_app.sh"); hl.dsp.submap("reset")
  end)
  hl.bind("escape", hl.dsp.submap("reset"))
  hl.bind("catchall", hl.dsp.submap("reset"))
end)

-- Google Submap
hl.bind("SUPER + G", hl.dsp.submap("google"))
hl.define_submap("google", function()
  hl.bind("M", function()
    hl.dsp.exec_cmd(GoogleMeet); hl.dsp.submap("reset")
  end)
  hl.bind("escape", hl.dsp.submap("reset"))
  hl.bind("catchall", hl.dsp.submap("reset"))
end)

hl.bind("SUPER + CTRL + ALT + B", hl.dsp.exec_cmd("~/.local/bin/battery_optimize.sh"))
