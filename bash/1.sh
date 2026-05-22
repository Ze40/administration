#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <file> <seconds>" >&2
    exit 1
fi

output_file=$1
duration=$2

if ! [[ $duration =~ ^[0-9]+$ ]]; then
    echo "Timeframe must be a non-negative integer" >&2
    exit 1
fi

: > "$output_file"

for ((i = 0; i < duration; i++)); do
    printf '%s = %s\n' "$(date '+%d.%m.%y %H:%M')" "$(cat /proc/loadavg)" >> "$output_file"
    sleep 1
done

