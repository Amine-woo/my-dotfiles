#!/bin/bash

# === CONFIG ===
PYWAL_COLORS="$HOME/.cache/wal/colors-waybar.css"
DISCORD_THEME="$HOME/.config/vesktop/themes/system24.theme.css"
BACKUP_THEME="$DISCORD_THEME.backup"

log() { echo "[$(date '+%H:%M:%S')] $1"; }

check_files() {
    [[ ! -f "$PYWAL_COLORS" ]] && { log "ERREUR: $PYWAL_COLORS introuvable"; exit 1; }
    [[ ! -f "$DISCORD_THEME" ]] && { log "ERREUR: $DISCORD_THEME introuvable"; exit 1; }
}

backup_theme() {
    if [[ ! -f "$BACKUP_THEME" ]]; then
        cp "$DISCORD_THEME" "$BACKUP_THEME"
        log "Sauvegarde créée → $BACKUP_THEME"
    fi
}

# --- run pywal restore if needed + wait for the wal file ---
ensure_wal() {
  # si le fichier n'existe pas ou est vide -> restaure le dernier thème pywal
  if [ ! -s "$PYWAL_COLORS" ]; then
    command -v wal >/dev/null && wal -R >/dev/null 2>&1 || true
  fi

  # attends que colors-waybar.css existe et contienne des couleurs
  for i in {1..50}; do
    if [ -s "$PYWAL_COLORS" ] && grep -q "@define-color" "$PYWAL_COLORS"; then
      return 0
    fi
    sleep 0.1
  done

  log "ATTENTION: $PYWAL_COLORS indisponible → je continue quand même"
}

# appelle ça au début de main()

extract_pywal_colors() {
    get_color() { grep -oP "@define-color $1 \K#[a-fA-F0-9]{6}" "$PYWAL_COLORS"; }
    FG=$(get_color foreground)
    BG=$(get_color background)
    C0=$(get_color color0)
    C1=$(get_color color1)
    C2=$(get_color color2)
    C3=$(get_color color3)
    C4=$(get_color color4)
    C5=$(get_color color5)
    C6=$(get_color color6)
    C7=$(get_color color7)

    ACCENT_PRIMARY="$C4"
    ACCENT_SECONDARY="$C6"
    BG_PRIMARY="$BG"
    BG_SECONDARY="$C0"
    BG_TERTIARY="$C1"
    TEXT_PRIMARY="$FG"
    TEXT_SECONDARY="$C7"
    TEXT_MUTED="$C3"
}


update_spicetify_colors() {
    local SPICE_THEME_DIR="$HOME/.config/spicetify/Themes/text"
    local COLOR_INI="$SPICE_THEME_DIR/color.ini"
    local SECTION="[Spotify]"  

    if [ ! -f "$COLOR_INI" ]; then
        log "Spicetify color.ini not found at $COLOR_INI"
        return
    fi

    log "Updating Spicetify theme colors from Discord variables..."

    # Convert from #xxxxxx to RRGGBB (remove the '#')
    hex_strip() { echo "$1" | tr -d '#'; }

    local accent=$(hex_strip "$ACCENT_PRIMARY")
    local accent_active=$(hex_strip "$ACCENT_SECONDARY")
    local bg_main=$(hex_strip "$BG_PRIMARY")
    local bg_secondary=$(hex_strip "$BG_SECONDARY")
    local text_primary=$(hex_strip "$TEXT_PRIMARY")
    local text_secondary=$(hex_strip "$TEXT_SECONDARY")

    awk -v section="$SECTION" \
        -v accent="$accent" \
        -v accent_active="$accent_active" \
        -v banner="$accent" \
        -v border_active="$accent_active" \
        -v border_inactive="$accent" \
        -v header="$accent" \
        -v highlight="$bg_secondary" \
        -v main="$bg_main" \
        -v notification="$accent_active" \
        -v subtext="$accent_inactive" \
        -v text="$accent_active" \
        'BEGIN{insec=0}
         /^\[/{insec=($0==section)}
         insec && /^accent\s*=/{$3=accent}
         insec && /^accent-active\s*=/{$3=accent_active}
         insec && /^banner\s*=/{$3=banner}
         insec && /^border-active\s*=/{$3=border_active}
         insec && /^border-inactive\s*=/{$3=border_inactive}
         insec && /^header\s*=/{$3=header}
         insec && /^highlight\s*=/{$3=highlight}
         insec && /^main\s*=/{$3=main}
         insec && /^notification\s*=/{$3=notification}
         insec && /^subtext\s*=/{$3=subtext}
         insec && /^text\s*=/{$3=text}
         {print}
        ' "$COLOR_INI" > "$COLOR_INI.tmp" && mv "$COLOR_INI.tmp" "$COLOR_INI"

    log "Spicetify colors updated. Applying..."
    spicetify apply >/dev/null 2>&1 && log "Spicetify applied."
}

update_theme() {
    tmp=$(mktemp)
    cp "$BACKUP_THEME" "$tmp"

    repl() { sed -E -i "s/(--$1:\s*)[^;]+;/\1$2;/g" "$tmp"; }

    # Backgrounds
    repl "bg-1" "$BG_PRIMARY"
    repl "bg-2" "$BG_SECONDARY"
    repl "bg-3" "$BG_SECONDARY"
    repl "bg-4" "$BG_SECONDARY"
    
    # Text
    repl "text-1" "$TEXT_PRIMARY"
    repl "text-2" "$TEXT_PRIMARY"
    repl "text-3" "$TEXT_SECONDARY"
    repl "text-4" "$TEXT_MUTED"
    repl "text-5" "$TEXT_MUTED"

    # Accents
    repl "accent-1" "$ACCENT_PRIMARY"
    repl "accent-2" "$ACCENT_SECONDARY"
    repl "accent-3" "$ACCENT_PRIMARY"
    repl "accent-4" "$ACCENT_SECONDARY"
    repl "accent-5" "$ACCENT_PRIMARY"
    repl "accent-new" "$ACCENT_PRIMARY"

    # Colors
    repl "red-1" "$C1"
    repl "red-2" "$C1"
    repl "red-3" "$C1"
    repl "red-4" "$C1"
    repl "red-5" "$C1"

    repl "green-1" "$C2"
    repl "green-2" "$C2"

    repl "blue-1" "$C5"
    repl "blue-2" "$C5"

    repl "purple-1" "$C4"
    repl "purple-2" "$C4"
    repl "purple-3" "$C1"
    repl "purple-4" "$C6"
    repl "purple-5" "$C6"

    # === Fonts (forcé à JetBrainsMono Nerd Font) ===
    sed -i "s|--font:.*;|--font: 'JetBrainsMono Nerd Font';|g" "$tmp"
    sed -i "s|--code-font:.*;|--code-font: 'JetBrainsMono Nerd Font';|g" "$tmp"

    mv "$tmp" "$DISCORD_THEME"
    log "Thème mis à jour avec les couleurs Pywal + JetBrainsMono Nerd Font"
}

main() {
    log "=== Sync Pywal → system24 ==="
    check_files
    backup_theme
    ensure_wal
    extract_pywal_colors
    update_theme
    update_spicetify_colors
    update_spicetify_ini
    
    log "=== Fini ==="
}

main