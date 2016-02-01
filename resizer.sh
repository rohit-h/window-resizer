#!/bin/bash -e

temp_dir="/tmp/win_info.$UID"
[ ! -e "$temp_dir" ] && mkdir "$temp_dir"

resize_me() {

    where_to="$1"

    set `xdotool getdisplaygeometry`
    half_width=$(( $1/2 ))
    half_height=$(( $2/2 ))
    full_width=$1
    full_height=$2

    case "$where_to" in

        "restore")
            load_state
            ;;

        "left")
            load_state
            save_state
            xdotool getactivewindow windowsize $half_width $full_height
            xdotool getactivewindow windowmove 0 0
            ;;

        "right")
            load_state
            save_state
            xdotool getactivewindow windowsize $half_width $full_height
            xdotool getactivewindow windowmove $half_width 0
            ;;

        "top")
            load_state
            save_state
            xdotool getactivewindow windowsize $full_width $half_height
            xdotool getactivewindow windowmove 0 0
            ;;

        "bottom")
            load_state
            save_state
            xdotool getactivewindow windowsize $full_width $half_height
            xdotool getactivewindow windowmove 0 $half_height
            ;;

        *) 
            echo "Usage: $0 [left|right|top|bottom|restore]"
            ;;
    esac

}

has_saved_state() {
    active_window=`xdotool getactivewindow`
    [ -e "$temp_dir/$active_window" ] && return 0
    return 1
}

save_state() {
    current_geometry=`xdotool getactivewindow getwindowgeometry | grep ':' | awk '{ print $2 }' | sed 's/[,x]/ /g'`
    echo $current_geometry > "$temp_dir/$active_window"
}

load_state() {
    has_saved_state || return 1
    set `cat "$temp_dir/$active_window"`
    xdotool getactivewindow windowmove $1 $2
    xdotool getactivewindow windowsize $3 $4
    sleep 0.5
}

resize_me $1
