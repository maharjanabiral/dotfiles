#!/bin/bash


SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config"

theme="$("$SCRIPT_DIR/rofi-launcher.sh")"

[ -z "$theme" ] && exit 0

THEME_PATH="$SCRIPT_DIR/$theme"

# Kitty
if [ -f "$THEME_PATH/kitty/colors.conf" ]; then
    cp "$THEME_PATH/kitty/colors.conf" \
       "$CONFIG_DIR/kitty/colors.conf"

    kitty @ set-colors -a "$CONFIG_DIR/kitty/colors.conf" 2>/dev/null
fi

echo "$theme" > "$SCRIPT_DIR/.current"

notify-send "Theme Applied" "$theme"