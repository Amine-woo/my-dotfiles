#!/bin/bash

# Récupère le player actif via playerctld (gère automatiquement le player en focus)
status=$(playerctl --player=playerctld metadata --format '{{lc(status)}}' 2>/dev/null)
player=$(playerctl --player=playerctld metadata --format '{{playerName}}' 2>/dev/null)

# Choisit une icône selon le player
case "$player" in
  *spotify*) icon="" ;;   # Icône Spotify
  *mpv*) icon="" ;;       # Icône MPV
  *vlc*) icon="" ;;       # Icône VLC
  *firefox*) icon="" ;;   # Icône Firefox
  *) icon="" ;;           # Icône générique musique
esac

text=""

if [[ $status == "playing" ]]; then
  info=$(playerctl --player=playerctld metadata --format '{{artist}} - {{title}}')
  if [[ ${#info} -gt 40 ]]; then
    info=$(echo "$info" | cut -c1-40)"..."
  fi
  text="$info $icon"
elif [[ $status == "paused" ]]; then
  text="$icon"
fi

echo -e "{\"text\":\"$text\", \"class\":\"$status\"}"
