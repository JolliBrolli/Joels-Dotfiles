-- Miscellaneous Settings (Hyprland 0.55)

hl.config({
  misc = {
    force_default_wallpaper = 0,      -- Set to 0 or 1 to disable the anime mascot wallpapers
    disable_hyprland_logo = true,     -- If true disables the random hyprland logo / anime girl background
    initial_workspace_tracking = 1,

    -- Variable Refresh Rate (VRR)
    -- 0: Off
    -- 1: Always On
    -- 2: Fullscreen Only
    vrr = 0,

    -- Variable Frame Rate (VFR)
    -- vfr = false,

    -- Mouse behavior
    mouse_move_enables_dpms = true,
    key_press_enables_dpms = true,

    -- Focus behavior
    focus_on_activate = false,
  }
})
