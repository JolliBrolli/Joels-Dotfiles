-- Input, Gestures, and Device Configuration (Hyprland 0.55)

hl.config({
    input = {
        kb_layout = "us",
        kb_variant = "",
        kb_model = "",
        kb_options = "ctrl:swapcaps",
        kb_rules = "",
        
        follow_mouse = 1,
        sensitivity = 0.5, -- -1.0 - 1.0, 0 means no modification

        touchpad = {
            disable_while_typing = true,
            natural_scroll = false,
        },
    },
})

-- Touchpad Gestures
-- Using the 0.55 gesture function syntax
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
hl.gesture({ fingers = 3, direction = "down", mod = "ALT", action = "close" })
hl.gesture({ fingers = 3, direction = "up", action = "float" })

-- Per-device config
hl.device({
    name = "epic-mouse-v1",
    sensitivity = -0.5,
})
