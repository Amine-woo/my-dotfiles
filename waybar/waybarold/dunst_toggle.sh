#!/bin/bash

# Moon (paused):  (U+F186)
# Bell (active):  (U+F0F3)

STATE=$(dunstctl is-paused)

if [ "$1" == "toggle" ]; then
    dunstctl set-paused toggle
    # Wait for state to update
    sleep 0.2
    STATE=$(dunstctl is-paused)
fi

if [ "$STATE" = "true" ]; then
    ICON=""  # Moon icon
    TEXT="Notifications Paused"
else
    ICON=""  # Bell icon
    TEXT="Notifications Active"
fi

echo "{\"text\": \"$ICON\", \"tooltip\": \"$TEXT\"}"
