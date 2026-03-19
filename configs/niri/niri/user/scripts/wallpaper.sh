#!/bin/bash

# setup
terminal=alacritty
walldir="/mnt/hdd/Wallpapers/walls/"
scripts="$HOME/.config/niri/user/scripts/"

# swww config
BEZIER=".43,1.19,1,.4"
SWWW_PARAMS="--transition-fps 60 --transition-type any --transition-duration 2 --transition-bezier $BEZIER"

rofi_theme="~/.config/rofi/wallpaper.rasi"

# Monitor details
scale_factor=$(niri msg outputs | grep "Scale:" | awk '{print $2}')
monitor_height=$(niri msg outputs | grep "Logical size:" | awk '{print $3}' | cut -d'x'
 -f2)

icon_size=$(echo "scale=1; ($monitor_height * 3) / ($scale_factor * 150)" | bc)
adjusted_icon_size=$(echo "$icon_size" | awk '{if ($1 < 15) $1 = 20; if ($1 > 25) $1 = 25; print $1}')
rofi_override="element-icon{size:500px;} listview{lines:1;columns:5;} window{width:90%;height:60%;}"

mapfile -d '' PICS < <(find -L "${walldir}" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o \
  -iname "*.webp" \) -print0)

rofi_command="rofi -i -dmenu -config $rofi_theme -theme-str $rofi_override"

# menu sorting

menu() {
  IFS=$'\n' sorted_wallpapers=($(sort <<<"${PICS[*]}"))
  pic_name=$(basename "$pic_path")

  for pic_path in "${sorted_wallpapers[@]}"; do
    printf "%s\x00icon\x1f%s\n" "$pic_path" "$pic_path"
  done
}

# apply wallpaper

apply_wallpaper() {
  local image_path="$1"
  swww img "$image_path" $SWWW_PARAMS
  matugen image "$image_path" -m "dark" -t "scheme-tonal-spot" --source-color-index "0"
  cp "$image_path" "$scripts/.wallpaper_current"
  sleep 2
  killall swaync && swaync &
  disown
  alacritty --title sddm -e bash -c "$scripts/sddm.sh"
}

# main
main() {
  # Use process substitution to pipe menu output into rofi command
  choice=$(menu | $rofi_command)

  # Check if Rofi returned an empty string (user likely pressed Escape)
  if [[ -z "$choice" ]]; then
    echo "No file selected, exiting."
    exit 0 # Exit cleanly
  fi

  image_to_apply="$choice"

  # Check if the file actually exists
  if [[ ! -f "$image_to_apply" ]]; then
    echo "Error: File not found for selected '$choice'"
    exit 1
  fi

  apply_wallpaper "$image_to_apply"
}

# Kill existing rofi instance before launching a new one
if pidof rofi >/dev/null; then
  pkill rofi
fi

main
