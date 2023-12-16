#!/bin/bash

BAT=$(acpi -b | grep -E -o '[0-9][0-9]?%')

# Full and short texts
echo "BAT: $BAT"

# Set urgent flag below 5% or use orange below 20%
[ ${BAT%?} -le 15 ] && exit 33
[ ${BAT%?} -le 25 ] && echo "#FF8000"

exit 0
