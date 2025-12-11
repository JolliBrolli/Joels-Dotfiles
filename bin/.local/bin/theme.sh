#!/bin/env zsh

echo ":: Theme switcher!"
hyprctl reload

if [[ "$1" == "catppuccin" ]]; then
  ln -sfn ~/.config/waybar/catppuccin_theme/catppuccin.css ~/.config/waybar/style.css
  ln -sfn ~/.config/hypr/conf/themes/catppuccin/catppuccin.conf ~/.config/hypr/hyprland.conf
fi



if [[ "$1" == "glass" ]]; then
  ln -sfn ~/.config/waybar/glass_theme/glass.css ~/.config/waybar/style.css
  ln -sfn ~/.config/hypr/conf/themes/glass/glass.conf ~/.config/hypr/hyprland.conf
fi

launch_waybar.sh
