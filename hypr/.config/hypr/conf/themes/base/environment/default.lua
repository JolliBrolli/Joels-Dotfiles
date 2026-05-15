-- Environment Variables
-- See https://wiki.hypr.land/Configuring/Environment-variables/

-- Standard variables
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("HYPRSHOT_DIR", os.getenv("HOME") .. "/pictures/screenshots")
hl.env("QT_QPA_PLATFORMTHEME", "gtk3")

-- Performance / Driver tweaks
hl.env("mesa_glthread", "false")
hl.env("__GL_THREADED_OPTIMIZATIONS", "0")

-- XDG Desktop Portals
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
