#!/bin/bash

if [ "$#" -ne 1 ]; then
    exit 1
fi

case "$1" in
    Mercury) echo 0 ;;
    Venus) echo 0 ;;
    Earth) echo 1 ;;
    Mars) echo 2 ;;
    Jupiter) echo 98 ;;
    Saturn) echo 83 ;;
    Uranus) echo 27 ;;
    Neptune) echo 14 ;;
    *)
        echo "Unknown planet"
        ;;
esac

