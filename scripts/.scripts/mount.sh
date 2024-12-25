#!/bin/sh

uid=$(id -u)
gid=$(id -g)

# Find USB devices
usbdev=$(ls -l /sys/dev/block/ | awk -F"/" '/usb/ && /sd/ {print "/dev/"$NF}')

if [ "$usbdev" ]; then
    selected=$( \
        lsblk -rno size,name,mountpoint $usbdev | \
        awk '($1!~"M" && $1!~"K") {printf "%s%8s%12s\n", $2, $1, $3}' | \
        dmenu -l 5 -i -p "USB Drives: " | awk '{print $1}' \
    )
    
    if grep -qs /dev/$selected /proc/mounts; then
        sync
        sudo umount /dev/$selected
        grep -qs /mnt/$selected /proc/mounts || sudo rm -rf /mnt/$selected
    else
        [ ! -d /mnt/$selected ] && sudo mkdir /mnt/$selected
        sudo mount -o uid=$uid,gid=$gid /dev/$selected /mnt/$selected
    fi
else 
    echo "No drives connected" | dmenu -i -p "USB Drives: "
    exit
fi

