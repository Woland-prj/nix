#!/usr/bin/env bash

# cached files paths
cache_file="$HOME/.cache/current_wallpaper"
cache_file="$HOME/.cache/current_wallpaper"
blurred="$HOME/.cache/blurred_wallpaper.png"
square="$HOME/.cache/square_wallpaper.png"
rofi="$HOME/.cache/rofi_wallpaper.png"
rasi_file="$HOME/.cache/current_wallpaper.rasi"

# create cash fie if not exist
if [ ! -f "$cache_file" ]; then
  touch "$cache_file"
  echo "$HOME/nix/wallpapers/default.jpg" > "$cache_file"
fi

#create rasi file if not exist
if [ ! -f "$rasi_file" ]; then
  touch "$rasi_file"
  echo "* { current-image: url(\"$HOME/nix/wallpapers/default.jpg\", height); }" > "$rasi_file"
fi

current_wallpaper="$(cat "$cache_file")"

case $1 in

    # Load wallpaper from .cache of last session 
    "init")
        sleep 1
        if [ -f $cache_file ]; then
            wal -q -i $current_wallpaper
        else
            wal -q -i ~/nix/wallpapers/
        fi
    ;;

    # Select wallpaper with rofi
    "select")
        sleep 0.2
        selected=$( find "$HOME/nix/wallpapers" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) -exec basename {} \; | sort -R | while read rfile
        do
            echo -en "$rfile\x00icon\x1f$HOME/nix/wallpapers/${rfile}\n"
        done | rofi -dmenu -i -replace -config ~/.config/rofi/config-wallpaper.rasi)
        if [ ! "$selected" ]; then
            echo "No wallpaper selected"
            exit
        fi
        echo ":: Selected: $selected"
        wal -q -i ~/nix/wallpapers/$selected
    ;;

    # Randomly select wallpaper 
    *)
        wal -q -i ~/nix/wallpapers/
    ;;

esac

# ----------------------------------------------------- 
# Load current pywal color scheme
# ----------------------------------------------------- 
source "$HOME/.cache/wal/colors.sh"
echo ":: Wallpaper: $wallpaper"

# ----------------------------------------------------- 
# get wallpaper image name
# ----------------------------------------------------- 
newwall=$(echo $wallpaper | sed "s|$HOME/nix/wallpapers/||g")

# ----------------------------------------------------- 
# Reload waybar with new colors
# -----------------------------------------------------
cp $HOME/.cache/wal/colors-waybar.css $HOME/.config/waybar/colors.css
~/nix/scripts/launch_waybar.sh

# ----------------------------------------------------- 
# Set the new wallpaper
# -----------------------------------------------------
transition_type="wipe"
# transition_type="outer"
# transition_type="random"

    # swww
echo ":: Using swww"
swww img $wallpaper \
        --transition-bezier .43,1.19,1,.4 \
        --transition-fps=60 \
        --transition-type=$transition_type \
        --transition-duration=0.7 \
        --transition-pos "$( hyprctl cursorpos )"

if [ "$1" == "init" ] ;then
    echo ":: Init"
else
    sleep 1
    dunstify "Changing wallpaper ..." "with image $newwall" -h int:value:13 -h string:x-dunst-stack-tag:wallpaper
    
    # ----------------------------------------------------- 
    # Reload Hyprctl.sh
    # -----------------------------------------------------
#    $HOME/.config/ml4w-hyprland-settings/hyprctl.sh &
fi

# -----------------------------------------------------
# Generate telegram theme
# -----------------------------------------------------
if [ "$1" == "init" ] ;then
    echo ":: Init"
else
    walogram
    sleep 0.5
    telegram-desktop &
    dunstify "Generating Telegram theme ..." "with image $newwall" -h int:value:25 -h string:x-dunst-stack-tag:wallpaper
fi


# ----------------------------------------------------- 
# Created blurred wallpaper
# -----------------------------------------------------
if [ "$1" == "init" ] ;then
    echo ":: Init"
else
    dunstify "Creating blurred version ..." "with image $newwall" -h int:value:63 -h string:x-dunst-stack-tag:wallpaper
fi

magick $wallpaper -resize 75% $rofi

# ----------------------------------------------------- 
# Created rofi wallpaper
# -----------------------------------------------------
if [ "$1" == "init" ] ;then
    echo ":: Init"
else
    dunstify "Creating rofi version ..." "with image $newwall" -h int:value:63 -h string:x-dunst-stack-tag:wallpaper
fi

magick $wallpaper -gravity Center -extent 1.33:1 $rofi
echo ":: Rofi version created"

# ----------------------------------------------------- 
# Created square wallpaper
# -----------------------------------------------------
if [ "$1" == "init" ] ;then
    echo ":: Init"
else
    dunstify "Creating square version ..." "with image $newwall" -h int:value:75 -h string:x-dunst-stack-tag:wallpaper
fi
magick $wallpaper -gravity Center -extent 1:1 $square
echo ":: Square version created"

# ----------------------------------------------------- 
# Write selected wallpaper into .cache files
# ----------------------------------------------------- 
echo "$wallpaper" > "$cache_file"
echo "* { current-image: url(\"$square\", height); }" > "$rasi_file"

# ----------------------------------------------------- 
# Send notification
# ----------------------------------------------------- 

if [ "$1" == "init" ] ;then
    echo ":: Init"
else
    dunstify "Wallpaper procedure complete!" "with image $newwall" -h int:value:100 -h string:x-dunst-stack-tag:wallpaper
fi

echo "DONE!"


