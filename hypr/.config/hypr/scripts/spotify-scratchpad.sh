#!/bin/bash

if ! pgrep -x spotify >/dev/null; then
    spotify &
    sleep 3
fi

