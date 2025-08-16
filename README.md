# 🌟 Hyprland Dotfiles – EndeavourOS

This repository contains my **Hyprland dotfiles** used on **EndeavourOS (Arch Linux)**.  
It includes my **Waybar configuration**, custom scripts for wallpapers and theming, and my terminal setup with **Zsh + Oh My Zsh + Powerlevel10k + Zoxide**.

⚠ THIS REPO IS A Work In Progress

---

## 👀 Showcase:
https://github.com/user-attachments/assets/39833267-8d45-44f9-b05c-4dd73c99e5a1

## 📂 Screenshots: 
<img width="3840" height="72" alt="image" src="https://github.com/user-attachments/assets/443fb6cb-1629-478c-8814-c804e9f8418a" />

<img width="3394" height="1674" alt="image" src="https://github.com/user-attachments/assets/42673556-de6b-4cf1-b8b9-7e948f663767" />
<img width="3840" height="1444" alt="image" src="https://github.com/user-attachments/assets/bef333f8-d005-4a9a-85c2-1f6bfdf6b63d" />
<img width="3370" height="1632" alt="image" src="https://github.com/user-attachments/assets/602ca205-2d6f-45f5-9b45-f48b3dd545d2" />

---

## 📂 Features

### 🔹 Waybar
- A clean and minimal status bar with modules for network, audio, battery, brightness, power profiles, and more.
- Styled with a custom `style.css` file for colors according to the pywal theme.

### 🔹 Wallpaper Scripts
- `wallpaperdaemon`  
  Runs automatically at startup. It launches **mpvpaper** for animated wallpapers and **pywal** to generate themes that apply to Waybar, Kitty, Rofi, ZenBrowser, and more.
- `wallpaperctl`  
  Allows you to switch wallpapers and themes instantly by pressing `SUPER+U`.

### 🔹 Terminal Setup
- **Terminal:** Kitty  
- **Shell:** Zsh with **Oh My Zsh** and the **Powerlevel10k** theme  
- **Plugins:**
  - [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
  - [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
  - [zsh-completions](https://github.com/zsh-users/zsh-completions)
  - [zoxide](https://github.com/ajeetdsouza/zoxide)

### 🔹 Discord TUI Pywal Theme:
- **What it does ?** Basically I made a script stored in ~/.config/vesktop/themes/theme.sh that updates [@refract0r](https://github.com/refact0r/system24) 's system24 theme to have the same colors as my theme (changes automatically as soon as I change wallpapers) !
<img width="3840" height="2160" alt="image" src="https://github.com/user-attachments/assets/a5247948-d531-46f1-8edc-3503a4125b8d" />


---
## ©️ Credits

- Waybar inspired by [@sansroot](https://github.com/sansroot/hypr-dots?tab=readme-ov-file)
- Thanks to [@OrigamingWasTaken](https://github.com/OrigamingWasTaken) for the wallpaper scripts and personally helping me with the rice!
---

## 🚀 Installation

Clone the repository and copy the configuration files to `~/.config`, add the Wallpaper folder to your home directory, add the rofi theme to `.local/rofi/themes` and install the dependencies:

```bash
git clone https://github.com/Amine-woo/my-dotfiles.git

cp -r ~/my-dotfiles/Wallpaper ~/
cp -r ~/my-dotfiles/.config/ ~/.config/

mkdir -p ~/.local/share/rofi/themes
cp -r ~/my-dotfiles/.local-rofi-themes/* ~/.local/share/rofi/themes/

# install the dependencies
