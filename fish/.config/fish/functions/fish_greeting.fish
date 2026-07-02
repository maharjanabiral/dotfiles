function fish_greeting
    echo -ne '\x1b[38;5;16m'  # Set colour to primary
    set_color normal
     if command -v fastfetch >/dev/null
        fastfetch --config ~/.config/fastfetch/config.jsonc
    end
end