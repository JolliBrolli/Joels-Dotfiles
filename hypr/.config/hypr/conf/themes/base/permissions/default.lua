-- Hyprland Permissions (Hyprland 0.55)
-- Note: Changes require a restart and are not applied on-the-fly.

-- Ecosystem settings
hl.config({
    ecosystem = {
        enforce_permissions = 1
    }
})

-- Security Rules
-- Format: hl.permission(path_regex, permission_type, action)
hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")
hl.permission("/usr/bin/quickshell", "screencopy", "allow")
