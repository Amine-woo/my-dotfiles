#!/bin/bash

if ! updates=$(checkupdates 2> /dev/null | wc -l); then
    updates=0
fi

if [ "$updates" -gt 0 ]; then
    echo "$updates"   # Icon for updates available
else
    echo "$updates"   # Icon for no updates
fi

