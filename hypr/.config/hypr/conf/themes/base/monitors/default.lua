-- Monitor Configuration
-- Syntax: hl.monitor(name, resolution, position, scale, options_table)
hl.monitor({
  output = "eDP-1",
  mode = "2880x1800@120",
  position = "0x0",
  scale = 1,
})

-- Lid Switch Logic
-- Use hl.bindl for "locked" binds (works when screen is off/locked)
-- For your config file
hl.bind("switch:on:Lid Switch", hl.dsp.dpms("off", "eDP-1"))
hl.bind("switch:off:Lid Switch", hl.dsp.dpms("on", "eDP-1"))
