#!/bin/bash
# Simple script to show the cpu temp formatted to be shown in polybar

cores=$(sensors | grep "Core" | sed "s/.*://" | sed "s/(.*)//" | sed "s/ //g" | sed "s/°C//" | sed "s/+//")

# TODO: Average numbers between cores
echo "$cores" | awk 'BEGIN{ RS = "" ; FS = "\n" }{ print $1 }'
