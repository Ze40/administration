#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <path>" >&2
    exit 1
fi

target_path=$1

if [ ! -d "$target_path" ]; then
    echo "Path does not exist"
    exit 1
fi

for dir in "$target_path"/*; do
    if [ -d "$dir" ]; then
        name=$(basename "$dir")
        count=$(find "$dir" -mindepth 1 -maxdepth 1 | wc -l)
        printf '%s\n' "$count" > "$name"
    fi
done

