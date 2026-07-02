#!/bin/bash

THEMES_DIR="$HOME/.config/colorschemes"

for dir in "$THEMES_DIR"/*/; do
    basename "$dir"
done | rofi -dmenu -i -p "Theme"