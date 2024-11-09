#!/bin/bash

SCREENSHOT_DIR="/home/$USER/Pictures/Screenshots"
SCREENSHOT_FILENAME="$SCREENSHOT_DIR/screenshot-$(date +"%Y%m%d-%H%M%S")"
SLOP_ARGS="-l -c 0.0,0.0,0.0,0.6 -b 2 -D"

mkdir -p "$SCREENSHOT_DIR"

case "$1" in
    "full")
        maim --format=png "${SCREENSHOT_FILENAME}-full.png"
        dunstify -i camera-photo "Screenshot Captured" "Full-screen screenshot saved"
        ;;
    "area")
        if GEOMETRY=$(slop $SLOP_ARGS); then
            maim --format=png -g $GEOMETRY "${SCREENSHOT_FILENAME}-area.png"
            dunstify -i camera-photo "Screenshot Captured" "Selected area screenshot saved"
        else
            dunstify -i camera-photo "Screenshot Cancelled" "No area selected"
            exit 1
        fi
        ;;
    *)
        echo "Usage: $0 [full|area]"
        exit 1
        ;;
esac

paplay /usr/share/sounds/freedesktop/stereo/camera-shutter.oga
