#!/bin/bash
# Simple script to show the cpu temp formatted to be shown in polybar

cores=$(sensors | grep "Core" | sed "s/.*://" | sed "s/(.*)//" | sed "s/ //g" | sed "s/°C//" | sed "s/+//")

# Average numbers between cores
echo "$cores" | awk '{s+=$1}END{print s/NR}' RS="\n"
