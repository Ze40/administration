#!/bin/bash

if [ "$FOO" = "5" ] && [ "$BAR" = "1" ]; then
    exit 1
fi

filename="fix.txt"

while [ ! -e "$filename" ]; do
    sleep 1
done

echo "File $filename found"

