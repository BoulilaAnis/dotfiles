#!/bin/bash
cpuPer=$(top -b -n1 | grep 'Cpu(s)' | awk '{print $2 + $4}')
cpuTemp=$(sensors | awk '/^temp1/ {gsub(/\+/, "", $2); print $2}')

echo "$cpuPer% - $cpuTemp"
