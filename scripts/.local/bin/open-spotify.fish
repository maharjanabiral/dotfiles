#!/usr/bin/env fish

set launched 0

if not pgrep -f '^spotify-launcher$' >/dev/null
    nohup spotify-launcher >/dev/null 2>&1 &
    set launched 1
end

if test $launched -eq 1
    sleep 2
end