#!/bin/bash

# Récupère l'état du player actif
status=$(playerctl --player=playerctld status 2>/dev/null)

# Détermine l'icône play/pause selon l'état
if [[ "$status" == "Playing" ]]; then
    play_icon=""   # pause
else
    play_icon=""   # play
fi

# On renvoie un JSON avec 3 "boutons" côte à côte
echo "{\"text\":\"⏮ $play_icon ⏭\", \"tooltip\":\"Media Controls\"}"
