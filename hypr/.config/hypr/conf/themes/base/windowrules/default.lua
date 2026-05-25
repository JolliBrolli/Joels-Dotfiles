-- ~/.config/hypr/conf/themes/base/windowrules/default.lua
-- Hyprland 0.55 Window Rule Migration

-- Define local variables for reuse
local Opacity = "1.0" -- Use numbers for opacity in 0.55
local floating_size = { 1000, 700 }
local mail_size = { 1200, 900 }

-- Suppress maximize requests globally
hl.window_rule({
  match = { class = ".*" },
  suppress_event = "maximize"
})

-- Foot terminal
hl.window_rule({
  name = "foot",
  match = { title = "(.*foot*.)" },
  workspace = "1",
  opacity = Opacity
})

-- Browsers (Workspace 2)
local browser_titles = { "(.*Firefox.*)", "(.*Vivaldi - Vivaldi.*)", "(.*Zen Browser.*)" }
for _, t in ipairs(browser_titles) do
  hl.window_rule({
    match = { title = t },
    workspace = 2,
    opacity = (t:find("Zen") and 0.99999 or Opacity)
  })
end

-- Development & Media
hl.window_rule({ match = { class = "com.code.editor" }, workspace = 3 })
hl.window_rule({ match = { class = "vivaldi-gemini.google.com__app-Default" }, workspace = 4 })
hl.window_rule({ match = { title = "(.*Spotify.*)" }, workspace = 5, })
hl.window_rule({ match = { title = "(.*Youtube.*)" }, workspace = 4 })

-- Mail Clients
local mail_match = { class = "^((chrome-mail\\.google\\.com__-Profile_1)|(chrome-mail\\.google\\.com__-Default))$" }
hl.window_rule({
  match = mail_match,
  float = true,
  size = mail_size,
  center = true
})

-- Utilities (Nautilus, Blueman, etc.)
local utils = {
  "org.gnome.Nautilus",
  "blueman-manager",
  "blueberry.py",
  "SonyHeadphonesClient",
  "org.pulseaudio.pavucontrol",
  "gcolor3",
  "evolution-alarm-notify",
  "xdg-desktop-portal-gtk"
}

for _, app in ipairs(utils) do
  hl.window_rule({
    match = { class = app },
    float = true,
    size = floating_size,
    center = true
  })
end

-- Rofi Blur (Layer Rules use same logic)
hl.layer_rule({
  match = { namespace = "rofi" },
  blur = true
})

-- XWayland Video Bridge
local bridge_match = { class = "^(xwaylandvideobridge)$" }
hl.window_rule({
  match = bridge_match,
  opacity = "0.0",
  no_anim = true,
  no_focus = true,
  max_size = { 1, 1 }
})

-- Webcam Bubble
hl.window_rule({
  match = { title = "^(webcam-bubble)$" },
  float = true,
  size = { 375, 375 },
  rounding = 20,
  move = "100%-w-20 100%-h-20"
})

hl.window_rule({
  match = { class = "^(vivaldi-app.gohighlevel.com__-Default)$"},
  workspace = 3,
  opacity = Opacity
})

hl.window_rule({
  match = { class = "^((org.gnome.Calendar))$"},
  workspace = 3,
  opacity = Opacity
})

hl.window_rule({
  match= { class = "^(vivaldi-meet.google.com__landing-Default)$"},
  workspace = 3,
  opacity = Opacity
})
-- Caelestia Shell (Layer Rules)
hl.layer_rule({
  match = { namespace = "caelestia-(launcher|osd|notifications|border-exclusion|area-p)" },
  no_anim = true
})
hl.layer_rule({
  match = { namespace = "caelestia-.*" },
  blur = true,
  ignore_alpha = 0.57
})
