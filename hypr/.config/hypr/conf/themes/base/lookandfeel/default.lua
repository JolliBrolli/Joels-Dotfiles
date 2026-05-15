-- -- Look and Feel Configuration (Hyprland 0.55
--
-- -- 1. Define your Curves (Beziers)
hl.curve("snappy", {
  type = "bezier",
  points = { { 0.1, 1 }, { 0.1, 1 } }
})
--
-- -- 2. Define Animations
hl.animation({ leaf = "global", enabled = true, speed = 2, bezier = "default" })
hl.animation({ leaf = "windows", enabled = true, speed = 2, bezier = "default", style = "slide" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1, bezier = "default", style = "slidefade" })
hl.animation({ leaf = "fade", enabled = true, speed = 1, bezier = "default" })
--
-- -- 3. Main Look and Feel Settings
hl.config({
  general = {
    gaps_in = 5,
    gaps_out = 10,
    border_size = 2,
    resize_on_border = true,
    allow_tearing = false,
    -- Hex colors work as strings in Lua
    ["col.active_border"] = "0xff777666",
    ["col.inactive_border"] = "0xff1a1b26",
  },

  decoration = {
    rounding = 20,
    rounding_power = 2,

    shadow = {
      enabled = true,
      range = 4,
      render_power = 3,
      color = "rgba(1a1a1aee)",
    },

    blur = {
      enabled = true,
      size = 5,
      passes = 3,
      vibrancy = 0.1696,
    },
  },

  dwindle = {
    --         -- pseudotile = true is removed in 0.55.0
    preserve_split = true,
  },

  master = {
    new_status = "master",
  },

  misc = {
    force_default_wallpaper = -1,
    disable_hyprland_logo = false,
    initial_workspace_tracking = 0,
    focus_on_activate = false,
    mouse_move_enables_dpms = true,
  }
})
