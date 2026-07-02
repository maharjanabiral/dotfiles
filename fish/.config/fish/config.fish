if status is-interactive
# Commands to run in interactive sessions can go here
# ---- Fish colors ----
set fish_greeting
source ~/.config/fish/functions/user-config.fish
end

starship init fish | source

fish_add_path /home/peekabooo/.spicetify
