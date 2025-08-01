# Hyprland Dotfiles

This repository contains my personal **Hyprland dotfiles**, including configurations for **Waybar**, **Rofi**, **Kitty**, and various scripts to improve workflow and aesthetics.
## 🖼ScreenShots:
<img width="2560" height="992" alt="image" src="https://github.com/user-attachments/assets/82d9d9c1-be25-4cef-a094-717130a336ef" />
<img width="2560" height="73" alt="image" src="https://github.com/user-attachments/assets/7cbf79fe-a77e-42dd-9661-23cd85f2df9a" />
<img width="2548" height="1235" alt="image" src="https://github.com/user-attachments/assets/1dba9aa3-9c22-49f3-a1c6-db8b5af319ee" />

---

## Features

### Wallpapers & Dynamic Themes
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
