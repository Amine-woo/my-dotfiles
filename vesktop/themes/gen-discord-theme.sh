#!/bin/bash

wal_colors="$HOME/.cache/wal/colors"
out="$HOME/.config/vesktop/themes/pywal-discord-static.theme.css"

# Lire les couleurs
readarray -t colors < "$wal_colors"

mkdir -p "$(dirname "$out")"

cat > "$out" <<EOF
:root {
  --color0: ${colors[0]};
  --color1: ${colors[1]};
  --color2: ${colors[2]};
  --color3: ${colors[3]};
  --color4: ${colors[4]};
  --color5: ${colors[5]};
  --color6: ${colors[6]};
  --color7: ${colors[7]};
  --color8: ${colors[8]};
  --color9: ${colors[9]};
  --color10: ${colors[10]};
  --color11: ${colors[11]};
  --color12: ${colors[12]};
  --color13: ${colors[13]};
  --color14: ${colors[14]};
  --color15: ${colors[15]};

  --background: var(--color0);
  --foreground: var(--color7);
  --accent: var(--color4);
  --muted: var(--color8);
}

html, body, .theme-dark, .appMount-3lHmkl {
  background-color: var(--background) !important;
  color: var(--foreground) !important;
}

/* Appliquer le fond sur les conteneurs, panels, chats, etc */
[class*="background"],
[class*="container"],
[class*="content"],
[class*="chat"],
[class*="sidebar"],
[class*="scroller"],
[class*="members"],
[class*="channel"],
[class*="panels"],
[class*="toolbar"],
[class*="wrapper"],
[class*="form"],
[class*="textarea"] {
  background-color: var(--background) !important;
  color: var(--foreground) !important;
}

/* Texte */
[class*="text"], [class*="title"], [class*="name"] {
  color: var(--foreground) !important;
}

/* Liens */
a {
  color: var(--color12) !important;
}

/* Hover interactif */
[class*="interactive"]:hover {
  background-color: var(--color1) !important;
}

/* Scrollbar */
::-webkit-scrollbar-thumb {
  background-color: var(--color4) !important;
}
::-webkit-scrollbar-track {
  background-color: var(--background) !important;
}

/* Zone de message */
textarea,
[class*="textArea"],
[class*="textArea"] > div,
[class*="textArea"] * {
  background-color: var(--color0) !important;
  color: var(--foreground) !important;
  border: 1px solid var(--color4) !important;
}

/* Panneau de sélection d'amis */
[class*="peopleColumn"],
[class*="nowPlayingColumn"] {
  background-color: var(--background) !important;
}
EOF

echo "✅ Thème écrit dans : $out"
