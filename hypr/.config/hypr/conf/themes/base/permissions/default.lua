-- Ecosystem settings
hl.config({
    ecosystem = {
        enforce_permissions = true
    }
})

-- Security Rules
-- Format: hl.permission({ binary = "regex", type = "permission", mode = "action" })
hl.permission({ binary = "/usr/(bin|local/bin)/grim", type = "screencopy", mode = "allow" })
hl.permission({ binary = "/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", type = "screencopy", mode = "allow" })
hl.permission({ binary = "/usr/(bin|local/bin)/hyprpm", type = "plugin", mode = "allow" })
hl.permission({ binary = "/usr/bin/quickshell", type = "screencopy", mode = "allow" })
hl.permission({ binary = "/usr/bin/hyprpicker", type = "screencopy", mode = "allow" })
