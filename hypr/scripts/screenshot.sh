#!/bin/bash

SCREENSHOT_DIR="$HOME/Pictures/Screenshots"
mkdir -p "$SCREENSHOT_DIR"

MODE="${1:-region}"

# Generate a unique filename in advance
FILENAME="screenshot-$(date +'%Y%m%d-%H%M%S').png"
FILEPATH="$SCREENSHOT_DIR/$FILENAME"

# Take the screenshot, specifying the filename
hyprshot -m "$MODE" -o "$SCREENSHOT_DIR" -f "$FILENAME" -s

# Wait for the file to exist and be non-empty (max 2 seconds)
for i in {1..20}; do
    if [[ -s "$FILEPATH" ]]; then
        break
    fi
    sleep 0.1
done

if [[ ! -s "$FILEPATH" ]]; then
    dunstify --urgency=critical -t 6000 "Screenshot failed" "No screenshot was taken."
    exit 1
fi

ACTION=$(dunstify --urgency=critical --icon="$FILEPATH" --action="default,Annotate" \
    -t 6000 \
    "Screenshot Taken" "Click to annotate with Swappy")

if [[ "$ACTION" == "default" ]]; then
    swappy -f "$FILEPATH"
fi

