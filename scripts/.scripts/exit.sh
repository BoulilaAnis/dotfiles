#!/bin/sh

choice=$(echo -e "Shutdown\nReboot\nExit" | dmenu)


[ $choice = "Shutdown" ] && sudo poweroff
[ $choice = "Reboot"   ] && sudo reboot
[ $choice = "Exit"     ] && pkill dwm
