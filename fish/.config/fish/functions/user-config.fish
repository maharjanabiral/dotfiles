function proj
    cd ~/Projects/
end

function cc
    if test (count $argv) -eq 0
        cd ~/.config/
    else
        cd ~/.config/$argv[1]
    end
end

function i
    yay -S $argv[1]
end

function u
    yay -Syu
end

function s
    yay -Ss $argv[1]
end

function r
    yay -Rns $argv[1]
end

function q
    yay -Q $argv[1]
end

function cl
    clear
end
