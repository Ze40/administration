#!/bin/bash

if [ "$#" -eq 0 ]; then
    exit 0
fi

for file in "$@"; do
    if [ ! -f "$file" ]; then
        printf '%s => not found\n' "$file"
        continue
    fi
    count=$(wc -l < "$file")
    printf '%s => %s\n' "$file" "$count"
done
