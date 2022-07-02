#!/bin/sh

# shopt -s nullglob
 
cd ~/Pictures/Wallpapers/background/

while true; do
    files=()
    # for i in *.jpg *.png; do
    for i in *.jpg *.png *.jpeg; do
        [[ -f $i ]] && files+=("$i")
    done
    range=${#files[@]}
    ((range)) && feh --bg-fill "${files[RANDOM % range]}"
    sleep 50m
done

# while true; do
#     find /home/ziya/Wallpapers/background/ -type f \( -name '*.jpg' -o -name '*.png' \) -print0 |
#         shuf -n1 -z | xargs -0 feh --bg-fill
#     sleep 15m
# done
