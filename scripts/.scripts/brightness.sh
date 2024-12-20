#!/bin/sh

arg=$1
[ $arg = "up"    ] && brightnessctl set 10%+
[ $arg = "down"  ] && brightnessctl set 10%-
