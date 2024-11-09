#!/bin/bash
scrot ~/dotfiles/starter_bg.jpg
convert /tmp/lockscreen.png -blur 0x0 /tmp/lockscreen.png
i3lock -i /tmp/lockscreen.png
