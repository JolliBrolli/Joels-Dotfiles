# #!/usr/bin/env zsh
# #  _   _           _       _             
# # | | | |_ __   __| | __ _| |_ ___  ___  
# # | | | | '_ \ / _` |/ _` | __/ _ \/ __| 
# # | |_| | |_) | (_| | (_| | ||  __/\__ \ 
# #  \___/| .__/ \__,_|\__,_|\__\___||___/ 
# #       |_|                              
# #  
#
# # Check if command exists
# _checkCommandExists() {
#     cmd="$1"
#     if ! command -v "$cmd" >/dev/null; then
#         echo 1
#         return
#     fi
#     echo 0
#     return
# }
#
# script_name=$(basename "$0")
#
# # Count the instances
# instance_count=$(ps aux | grep -F "$script_name" | grep -v grep | grep -v $$ | wc -l)
#
# if [ $instance_count -gt 1 ]; then
#     sleep $instance_count
# fi
#
#
# # ----------------------------------------------------- 
# # Define threshholds for color indicators
# # ----------------------------------------------------- 
#
# threshhold_green=0
# threshhold_yellow=25
# threshhold_red=100
#
# # ----------------------------------------------------- 
# # Check for updates
# # ----------------------------------------------------- 
#
# # Arch
# if [[ $(_checkCommandExists "pacman") == 0 ]]; then
#     aur_helper="$(cat ~/.local/bin/aur.sh)"
#
#     check_lock_files() {
#         local pacman_lock="/var/lib/pacman/db.lck"
#         local checkup_lock="${TMPDIR:-/tmp}/checkup-db-${UID}/db.lck"
#
#         while [ -f "$pacman_lock" ] || [ -f "$checkup_lock" ]; do
#             sleep 1
#         done
#     }
#
#     check_lock_files
#
#     # Use checkupdates for reliable update checking
#     updates=$(checkupdates 2>/dev/null | wc -l)
# # Fedora
# elif [[ $(_checkCommandExists "dnf") == 0 ]]; then
#     updates=$(dnf check-update -q | grep -c ^[a-z0-9])
# # Others
# else
#     updates=0
# fi
#
#
# # ----------------------------------------------------- 
# # Output in JSON format for Waybar Module custom-updates
# # ----------------------------------------------------- 
# css_class="green"
#
# if [ "$updates" -gt $threshhold_yellow ]; then
#     css_class="yellow"
# fi
#
# if [ "$updates" -gt $threshhold_red ]; then
#     css_class="red"
# fi
#
# if [ "$updates" != 0 ]; then
#     if [ "$updates" -gt $threshhold_green ]; then
#         printf '{"text": "%s", "alt": "%s", "tooltip": "Click to update your system", "class": "%s"}' "$updates" "$updates" "$css_class"
#     else
#         printf '{"text": "0", "alt": "0", "tooltip": "No updates available", "class": "green"}'
#     fi
# fi

#!/usr/bin/env zsh

# Check if command exists
_checkCommandExists() {
    cmd="$1"
    if ! command -v "$cmd" >/dev/null; then echo 1; else echo 0; fi
}

script_name=$(basename "$0")
instance_count=$(ps aux | grep -F "$script_name" | grep -v grep | grep -v $$ | wc -l)
[ $instance_count -gt 1 ] && sleep $instance_count

# ----------------------------------------------------- 
# Initialize Counts
# ----------------------------------------------------- 
count_repo=0
count_aur=0
count_flatpak=0

# ----------------------------------------------------- 
# 1. Official Repo Updates (Filtered for Explicitly Installed)
# ----------------------------------------------------- 
if [[ $(_checkCommandExists "pacman") == 0 ]]; then
    # Arch: Compare available updates against your "Explicitly Installed" list
    count_repo=$(comm -12 <(checkupdates 2>/dev/null | awk '{print $1}' | sort) <(pacman -Qeq | sort) | wc -l)
    
    # Check AUR (yay or paru)
    if [[ $(_checkCommandExists "paru") == 0 ]]; then
        count_aur=$(comm -12 <(paru -Qua 2>/dev/null | awk '{print $1}' | awk -F/ '{print $NF}' | sort) <(pacman -Qeq | sort) | wc -l)
    elif [[ $(_checkCommandExists "yay") == 0 ]]; then
        count_aur=$(comm -12 <(yay -Qua 2>/dev/null | awk '{print $1}' | sort) <(pacman -Qeq | sort) | wc -l)
    fi

elif [[ $(_checkCommandExists "dnf") == 0 ]]; then
    # Fedora: Filter dnf updates by user-installed history
    count_repo=$(dnf check-update -q --queryformat "%{name}" 2>/dev/null | grep -Fxf <(dnf history userinstalled | awk '{print $1}') | wc -l)
fi

# ----------------------------------------------------- 
# 2. Flatpak Updates (Apps only, no Runtimes)
# ----------------------------------------------------- 
if [[ $(_checkCommandExists "flatpak") == 0 ]]; then
    # 1. Get IDs of apps with updates available
    # 2. Get IDs of all installed apps (skipping the header line with tail)
    # 3. Count only the ones that appear in both lists
    updates_list=$(flatpak remote-ls --updates --columns=application 2>/dev/null)
    installed_list=$(flatpak list --app --columns=application | tail -n +1)
    
    count_flatpak=$(grep -Fxf <(echo "$updates_list") <(echo "$installed_list") | wc -l)
fi

# ----------------------------------------------------- 
# 3. Sum and Output
# ----------------------------------------------------- 
total_updates=$((count_repo + count_aur + count_flatpak))

# Set thresholds for color indicators
css_class="green"
[ "$total_updates" -gt 5 ] && css_class="yellow"
[ "$total_updates" -gt 15 ] && css_class="red"

if [ "$total_updates" -gt 0 ]; then
    printf '{"text": "%s", "alt": "%s", "tooltip": "Repo: %s | AUR: %s | Flatpak: %s", "class": "%s"}' \
        "$total_updates" "$total_updates" "$count_repo" "$count_aur" "$count_flatpak" "$css_class"
else
    printf '{"text": "0", "alt": "0", "tooltip": "Everything is up to date", "class": "green"}'
fi
