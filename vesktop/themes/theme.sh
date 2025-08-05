#!/bin/bash

# Script de synchronisation Discord avec pywal
# Synchronise le thème system24 Discord avec les couleurs pywal et rafraîchit Waybar
# Usage: ./theme.sh

# Configuration des chemins
PYWAL_COLORS="$HOME/.cache/wal/colors-waybar.css"
DISCORD_THEME="$HOME/.config/vesktop/themes/system24.theme.css"
BACKUP_THEME="$HOME/.config/vesktop/themes/system24.theme.css.backup"

# Couleurs par défaut si pywal n'est pas disponible
DEFAULT_COLORS="$HOME/.config/discord-theme-backup/default-colors.css"

# Fonction de log
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

# Vérifier si les fichiers nécessaires existent
check_requirements() {
    if [ ! -f "$PYWAL_COLORS" ]; then
        log "ERREUR: Fichier pywal introuvable: $PYWAL_COLORS"
        log "Assurez-vous que pywal est installé et configuré"
        exit 1
    fi
    
    if [ ! -f "$DISCORD_THEME" ]; then
        log "ERREUR: Thème Discord introuvable: $DISCORD_THEME"
        log "Assurez-vous que le thème system24 est installé dans Vesktop"
        exit 1
    fi
}

# Créer une sauvegarde du thème original
create_backup() {
    if [ ! -f "$BACKUP_THEME" ]; then
        cp "$DISCORD_THEME" "$BACKUP_THEME"
        log "Sauvegarde créée: $BACKUP_THEME"
    fi
}

# Extraire les couleurs de pywal
extract_pywal_colors() {
    local foreground=$(grep -oP '@define-color foreground \K#[a-fA-F0-9]{6}' "$PYWAL_COLORS")
    local background=$(grep -oP '@define-color background \K#[a-fA-F0-9]{6}' "$PYWAL_COLORS")
    local color0=$(grep -oP '@define-color color0 \K#[a-fA-F0-9]{6}' "$PYWAL_COLORS")
    local color1=$(grep -oP '@define-color color1 \K#[a-fA-F0-9]{6}' "$PYWAL_COLORS")
    local color2=$(grep -oP '@define-color color2 \K#[a-fA-F0-9]{6}' "$PYWAL_COLORS")
    local color3=$(grep -oP '@define-color color3 \K#[a-fA-F0-9]{6}' "$PYWAL_COLORS")
    local color4=$(grep -oP '@define-color color4 \K#[a-fA-F0-9]{6}' "$PYWAL_COLORS")
    local color5=$(grep -oP '@define-color color5 \K#[a-fA-F0-9]{6}' "$PYWAL_COLORS")
    local color6=$(grep -oP '@define-color color6 \K#[a-fA-F0-9]{6}' "$PYWAL_COLORS")
    local color7=$(grep -oP '@define-color color7 \K#[a-fA-F0-9]{6}' "$PYWAL_COLORS")
    
    ACCENT_PRIMARY="$color4"
    ACCENT_SECONDARY="$color6"
    BG_PRIMARY="$background"
    BG_SECONDARY="$color0"
    BG_TERTIARY="$color1"
    TEXT_PRIMARY="$foreground"
    TEXT_SECONDARY="$color7"
    TEXT_MUTED="$color3"
    Color1="$color1"
    Color2="$color2"
    Color3="$color3"
    Color4="$color4"
    Color5="$color5"
    Color6="$color6"
    Color7="$color7"
    
    log "Couleurs extraites de pywal."
}

# Créer les dossiers nécessaires
setup_directories() {
    local theme_dir=$(dirname "$DISCORD_THEME")
    local backup_dir=$(dirname "$DEFAULT_COLORS")
    mkdir -p "$theme_dir" "$backup_dir" 2>/dev/null
    log "Dossiers créés/vérifiés"
}

# --- FONCTION MODIFIÉE ---
# Rafraîchir Waybar de manière robuste (Tuer et relancer)
refresh_waybar() {
    log "Rafraîchissement de Waybar..."
    # Tuer poliment toute instance existante de Waybar
    killall -q waybar
    # Attendre que le processus soit complètement terminé pour éviter les conflits
    while pgrep -x waybar > /dev/null; do sleep 0.1; done
    # Démarrer une nouvelle instance de Waybar en arrière-plan
    log "Démarrage d'une nouvelle instance de Waybar."
    waybar &
}

# Générer le CSS avec les nouvelles couleurs
generate_discord_css() {
    local temp_file=$(mktemp)
    cp "$BACKUP_THEME" "$temp_file"
    
    local accent_light=$(echo "$ACCENT_PRIMARY" | sed 's/#//' | awk '{r=("0x"substr($0,1,2))+20; g=("0x"substr($0,3,2))+20; b=("0x"substr($0,5,2))+20; if(r>255)r=255; if(g>255)g=255; if(b>255)b=255; printf "#%02x%02x%02x\n", r, g, b}')
    local accent_dark=$(echo "$ACCENT_PRIMARY" | sed 's/#//' | awk '{r=("0x"substr($0,1,2))-20; g=("0x"substr($0,3,2))-20; b=("0x"substr($0,5,2))-20; if(r<0)r=0; if(g<0)g=0; if(b<0)b=0; printf "#%02x%02x%02x\n", r, g, b}')
    
    sed -i "
        s/--red-1: oklch([^;]*);/--red-1: #ffffff;/g; s/--red-2: oklch([^;]*);/--red-2: $ACCENT_PRIMARY;/g;
        s/--red-3: oklch([^;]*);/--red-3: $Color1;/g; s/--red-4: oklch([^;]*);/--red-4: $Color1;/g;
        s/--red-5: oklch([^;]*);/--red-5: $Color1;/g; s/--green-1: oklch([^;]*);/--green-1: $Color1;/g;
        s/--green-2: oklch([^;]*);/--green-2: $Color2;/g; s/--blue-1: oklch([^;]*);/--blue-1: $Color5;/g;
        s/--blue-2: oklch([^;]*);/--blue-2: $Color5;/g; s/--font: '.*';/--font: 'JetBrainsMono Nerd Font';/g;
        s/--code-font: '.*';/--code-font: 'JetBrainsMono Nerd Font';/g; s/--accent-1: [^;]*;/--accent-1: $BG_TERTIARY;/g;
        s/--accent-new: [^;]*;/--accent-new: $BG_TERTIARY;/g; s/--accent-5: var(--purple-5);/--accent-5: #ff5555;/g;
        s/--button-danger-background: [^;]*;/--button-danger-background: #ff5555;/g;
        s/--purple-1: oklch([^;]*);/--purple-1: $accent_light;/g; s/--purple-2: oklch([^;]*);/--purple-2: $ACCENT_PRIMARY;/g;
        s/--purple-3: oklch([^;]*);/--purple-3: $BG_TERTIARY;/g; s/--purple-4: oklch([^;]*);/--purple-4: $ACCENT_SECONDARY;/g;
        s/--purple-5: oklch([^;]*);/--purple-5: $ACCENT_SECONDARY;/g; s/--bg-1: oklch([^;]*);/--bg-1: $BG_PRIMARY;/g;
        s/--bg-2: oklch([^;]*);/--bg-2: $BG_SECONDARY;/g; s/--bg-3: oklch([^;]*);/--bg-3: $BG_SECONDARY;/g;
        s/--bg-4: oklch([^;]*);/--bg-4: $BG_SECONDARY;/g; s/--text-1: oklch([^;]*);/--text-1: $TEXT_PRIMARY;/g;
        s/--text-2: oklch([^;]*);/--text-2: $TEXT_PRIMARY;/g; s/--text-3: oklch([^;]*);/--text-3: $TEXT_SECONDARY;/g;
        s/--text-4: oklch([^;]*);/--text-4: $TEXT_MUTED;/g; s/--text-5: oklch([^;]*);/--text-5: $TEXT_MUTED;/g;
    " "$temp_file"
    
    mv "$temp_file" "$DISCORD_THEME"
    log "Thème Discord mis à jour avec les couleurs pywal"
}

# Fonction principale
main() {
    log "=== Début de la synchronisation Discord <-> Pywal ==="
    check_requirements
    setup_directories
    create_backup
    extract_pywal_colors
    generate_discord_css
    refresh_waybar
    log "=== Synchronisation terminée avec succès ==="
}

# Fonction de restauration
restore_backup() {
    if [ -f "$BACKUP_THEME" ]; then
        cp "$BACKUP_THEME" "$DISCORD_THEME"
        log "Thème original restauré"
        refresh_waybar
    else
        log "ERREUR: Aucune sauvegarde trouvée"
        exit 1
    fi
}

# Gestion des arguments
case "${1:-}" in
    --restore|-r)
        restore_backup
        ;;
    --help|-h)
        echo "Usage: $0 [OPTIONS]"
        echo "Synchronise le thème Vesktop system24 avec les couleurs pywal et rafraîchit Waybar"
        echo ""
        echo "OPTIONS:"
        echo "  --restore, -r    Restaure le thème original et rafraîchit Waybar"
        echo "  --help, -h       Affiche cette aide"
        echo ""
        echo "Pour utiliser avec une keybind Hyprland, ajoutez dans votre config:"
        echo "bind = \$mainMod, F5, exec, $0"
        ;;
    *)
        main
        ;;
esac