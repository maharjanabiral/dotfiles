#!/usr/bin/env fish

set launched 0

if not pgrep -x vesktop >/dev/null
    nohup vesktop >/dev/null 2>&1 &
    set launched 1
end

if test $launched -eq 1
    sleep 0.3
end

