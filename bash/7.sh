#!/bin/bash

IFS=':' read -r -a path_entries <<< "$PATH"

for entry in "${path_entries[@]}"; do
    [ -d "$entry" ] || continue
    count=$(find "$entry" -maxdepth 1 -type f | wc -l)

    printf '%s=>%s\n' "$entry" "$count"
done

