#!/bin/bash

IFS=':' read -r -a path_entries <<< "$PATH"

for entry in "${path_entries[@]}"; do
    if [ -d "$entry" ]; then
        count=$(find "$entry" -maxdepth 1 -type f | wc -l)
    else
        count=0
    fi

    printf '%s=>%s\n' "$entry" "$count"
done

