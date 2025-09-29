#!/bin/zsh

# Directory where your tracked lists live
OUTDIR="$HOME/.dotfiles/installed_packages"

echo "Updating package lists in $OUTDIR..."

# Pacman (explicit packages)
pacman -Qqe > "$OUTDIR/pkglist.txt"
echo "✔ Saved pacman package list to pkglist.txt"

# Flatpak
if command -v flatpak >/dev/null 2>&1; then
    flatpak list --app --columns=application > "$OUTDIR/flatpaklist.txt"
    echo "✔ Saved flatpak list to flatpaklist.txt"
else
    echo "⚠ Flatpak not installed, skipping flatpaklist.txt"
fi

# AUR / foreign packages (anything not in official repos)
pacman -Qqem > "$OUTDIR/aurlist.txt"
echo "✔ Saved AUR package list to aurlist.txt"

echo "✅ All lists updated!"

