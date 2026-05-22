#!/bin/bash

reference_value=
found_any=0

while IFS='=' read -r name value; do
    if [ $found_any -eq 0 ]; then
        reference_value=$value
        found_any=1
        continue
    fi

    if [ "$value" != "$reference_value" ]; then
        exit 1
    fi
done < <(env | grep '^LC_' | sort)

