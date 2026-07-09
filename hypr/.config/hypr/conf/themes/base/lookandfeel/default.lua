-- -- Look and Feel Configuration (Adwaita/GNOME Fluid Style)
--
-- -- 1. Define your Curves (Beziers & Libadwaita-style Springs)
-- A clean, organic ease-out curve for classic GTK-style linear transitions
hl.curve("adwaita_ease", {
  type = "bezier",
  points = { { 0.25, 1 }, { 0.5, 1 } }
})

-- Adwaita springs are highly dampened. They move with intent and avoid gaming-style "bounce".
-- Tuning formula target: Dampening ≈ 2 * sqrt(stiffness * mass)
hl.curve("adw_window", { type = "spring", mass = 1.0, stiffness = 110, dampening = 20 })
hl.curve("adw_workspace", { type = "spring", mass = 1.0, stiffness = 95, dampening = 19 })
hl.curve("adw_menu", { type = "spring", mass = 1.0, stiffness = 130, dampening = 22 })
hl.curve("adw_fade", { type = "spring", mass = 1.0, stiffness = 100, dampening = 20 })

-- -- 2. Define Animations
hl.animation({ leaf = "global", enabled = true, speed = 1, spring = "default" })

-- Windows: 'popin 90%' gives you that native GNOME window opening scale-in effect
hl.animation({ leaf = "windows", enabled = true, speed = 1, spring = "adw_window", style = "popin 90%" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 1, spring = "adw_window" })

-- Workspaces: A smooth horizontal slide replicating the GNOME 40+ overview layout panning
hl.animation({ leaf = "workspaces", enabled = true, speed = 1, spring = "adw_workspace", style = "slide" })

-- Fade & Layers: Clean, invisible transitions for menus, tooltips, and background blurs
hl.animation({ leaf = "fade", enabled = true, speed = 1, spring = "adw_fade" })
hl.animation({ leaf = "layers", enabled = true, speed = 1, spring = "adw_menu", style = "popin 85%" })

-- -- 3. Main Look and Feel Settings (Adwaita Theme Sync)
hl.config({
  general = {
    gaps_in = 6,
    gaps_out = 6,
    border_size = 2,
    resize_on_border = true,
    allow_tearing = false,
    -- Matches Adwaita Dark's clean, subtle charcoal/gray border accents
    ["col.active_border"] = "rgb(5e5e5e)",
    ["col.inactive_border"] = "rgb(2d2d2d)",
  },

  decoration = {
    rounding = 12, -- Absolute sweet spot for Libadwaita window corners

    shadow = {
      enabled = true,
      range = 15,
      render_power = 3,
      color = "rgba(00000044)", -- Softened up slightly for an elegant drop shadow
    },

    blur = {
      enabled = true,
      size = 5,
      passes = 3,
      vibrancy = 0.1696,
    },
  },

  dwindle = {
    preserve_split = true,
  },

  master = {
    new_status = "master",
  },

  misc = {
    force_default_wallpaper = 0,
    disable_hyprland_logo = true,
    initial_workspace_tracking = false,
    focus_on_activate = false,
    mouse_move_enables_dpms = true,
  }
})
