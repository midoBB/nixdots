#!/usr/bin/env bash

theme="powermenu"
dir="$HOME/.config/rofi"
run_rofi() {
    tmp=$(mktemp)
    if autorandr --list > "$tmp"; then
        rofi -dmenu \
            -p "Monitor setup" \
            -mesg "Choose the desired monitor configuration : " \
            -theme "${dir}/${theme}.rasi" < "$tmp"
    fi
    rm -f "$tmp"
}

chosen="$(run_rofi)"
if [ -z "$chosen" ]; then
    exit 0;
fi

autorandr -c "$chosen" &&
systemctl --user restart polybar.service
exit 0
