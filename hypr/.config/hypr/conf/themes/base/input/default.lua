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
hl.gesture({ fingers = 3, direction = "down", action = "close" })
hl.bind("mouse:274", function()
  hl.dispatch(hl.dsp.window.float({ action = "toggle" }))
  hl.dispatch(hl.dsp.window.resize({ x = 1800, y = 1200 }))
  -- hl.dispatch(hl.dsp.window.center())
end)

-- Swipe up with 3 fingers to move it
hl.gesture({
  fingers = 3,
  direction = "up",
  action = "move"
})

-- hl.gesture({ fingers = 4, direction = right, action = movetoworkspace +1})

-- Per-device config
hl.device({
  name = "epic-mouse-v1",
  sensitivity = -0.5,
})
