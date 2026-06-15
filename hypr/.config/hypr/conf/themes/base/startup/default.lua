-- Essential Environment Setup
-- Imports Wayland variables into systemd and dbus
hl.on("hyprland.start", function()
  -- Environment Initialization & Portal Sync (Chained sequentially to prevent race conditions)
hl.exec_cmd("bash -c 'dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP HYPRLAND_INSTANCE_SIGNATURE DBUS_SESSION_BUS_ADDRESS DISPLAY XAUTHORITY && systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP HYPRLAND_INSTANCE_SIGNATURE'")
  -- Security and System Services
  hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
  hl.exec_cmd("sudo powertop --auto-tune")
  hl.exec_cmd("gnome-keyring-daemon --start --components=secrets,ssh,pkcs11")
  hl.exec_cmd("/usr/lib/evolution-data-server/evolution-alarm-notify")

  -- Hardware Specifics (Zenbook/Asus)
  hl.exec_cmd("asusctl profile set quiet")
  hl.exec_cmd("~/.local/bin/zenbook_edge_handler.py")
  hl.exec_cmd("~/.local/bin/battery_optimize.sh")

  -- Theming and UI (GTK/Portals)
  hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'")
  hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'")
  hl.exec_cmd("nwg-look -a")
  -- hl.exec_cmd("~/.local/bin/portal-sync.sh")

  -- Apps and Shell
  -- hl.exec_cmd("caelestia shell -d")
  -- hl.exec_cmd("ambxst")
  hl.exec_cmd("qs")
  -- hl.exec_cmd("flatpak run --command=valent ca.andyholmes.Valent --gapplication-service")

  hl.exec_cmd("sleep 2 && /usr/local/bin/wifi-powersave-off.sh")

  -- Workspace-Specific Autostart
  -- hl.exec_cmd("[workspace 2 silent] ~/.local/bin/run_browser.sh")
  -- hl.exec_cmd("[workspace special:magic silent] spotify")
end)
