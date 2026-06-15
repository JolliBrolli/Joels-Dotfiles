-- -- Look and Feel Configuration (Hyprland 0.55
--
-- -- 1. Define your Curves (Beziers)
hl.curve("snappy", {
  type = "bezier",
  points = { { 0.1, 1 }, { 0.1, 1 } }
})

hl.curve("spring_menu", { type = "spring", mass = 1, stiffness = 80, dampening = 14 })
hl.curve("spring_window", { type = "spring", mass = 1, stiffness = 30, dampening = 8 })
hl.curve("spring_open", { type = "spring", mass = 1, stiffness = 30, dampening = 8 })
hl.curve("spring_workspace", { type = "spring", mass = 1.2, stiffness = 30, dampening = 10 })
hl.curve("spring_special", { type = "spring", mass = 1, stiffness = 30, dampening = 8 })
--
-- -- 2. Define Animations
hl.animation({ leaf = "global", enabled = true, speed = 2, spring = "default" })
hl.animation({ leaf = "windows", enabled = true, speed = 2, spring = "spring_window", style = "slide" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1, spring = "spring_workspace", style = "slidefade" })
hl.animation({ leaf = "fade", enabled = true, speed = 1, spring = "spring_open" })
--
-- -- 3. Main Look and Feel Settings
hl.config({
  general = {
    gaps_in = 2,
    gaps_out = 4,
    border_size = 2,
    resize_on_border = true,
    allow_tearing = false,
    -- Hex colors work as strings in Lua
    -- ["col.active_border"] = "0xff777666",
    -- ["col.inactive_border"] = "0xff1a1b26",
  },

  decoration = {
    rounding = 16,
    -- rounding_power = 2,

    shadow = {
      enabled = true,
      range = 8,
      color = "rgba(00000080)",
    },

    blur = {
      enabled = true,
      size = 4,
      passes = 2,
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
    disable_hyprland_logo = true,
    initial_workspace_tracking = 0,
    focus_on_activate = false,
    mouse_move_enables_dpms = true,
  }
})
