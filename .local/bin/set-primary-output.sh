#!/bin/bash

OUTPUTS=$(xrandr | grep " connected " | awk '{ print$1 }')
DEFAULT=$(xrandr | grep " connected " | awk '{ print$1 }' | head -n 1)

if grep -qw "DP-3" <<< "$OUTPUTS"; then
  #echo 'set DP-3 as primary output'
  xrandr --output "DP-3" --primary
elif grep -q "DP-1" <<< "$OUTPUTS"; then
  #echo 'set DP-1 as primary output'
  xrandr --output "DP-1"
else
  #echo "set default $DEFAULT as primary output"
  xrandr --output $DEFAULT --primary
fi
