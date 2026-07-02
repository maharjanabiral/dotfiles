#!/bin/bash

if ! pgrep -x vesktop >/dev/null; then
    discord &
    sleep 3
fi

hyprctl dispatch togglespecialworkspace vesktop
