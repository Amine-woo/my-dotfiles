# Hyprland Dotfiles

This repository contains my personal **Hyprland dotfiles**, including configurations for **Waybar**, **Rofi**, **Kitty**, and various scripts to improve workflow and aesthetics.

---

## Features

### 🖼 Wallpapers & Dynamic Themes
- **`wallpaperdaemon`**  
  - Automatically starts on login.  
  - Launches **mpvpaper** for animated wallpapers.  
  - Runs **pywal** to generate color schemes applied to **Kitty**, **Waybar**, **Zen Browser**, and **Rofi**.  

- **`wallpaperctl`**  
  - Switches wallpaper and theme with **SUPER+U**.

---

### Waybar Integration
- **Network management:** `networkmanager-dmenu`
- **Brightness control:** `brightnessctl`
- **Power profiles:** `powerprofilesctl`
- **Session menu:** logout, shutdown, reboot, or reboot to Windows via `wlogout`

---

### Terminal
- **Kitty** terminal with:
  - **zsh**, **oh-my-zsh**
  - **Powerlevel10k**
  - **Autocompletion** and **autosuggestions**

---

### Other Tools
- Additional scripts for screenshots and various utilities (check the `scripts/` folder).

---

## Installation

```bash
# Clone the repository
git clone https://github.com/<your-username>/<repo-name>.git ~/.config

# (Optional) Symlink to .config
ln -s ~/.config/<repo-name>/* ~/.config/
