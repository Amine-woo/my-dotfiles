Hyprland Dotfiles

This repository contains my personal Hyprland dotfiles, including configurations for Waybar, Rofi, Kitty, and various scripts to improve the workflow and aesthetics of my setup.
Features

    Animated wallpapers & dynamic themes

        wallpaperdaemon: Automatically launches on startup. It runs mpvpaper for animated wallpapers and pywal to generate matching color schemes applied to Kitty, Waybar, Zen Browser, and Rofi.

        wallpaperctl: Allows switching wallpaper and theme with SUPER+U.

    Waybar setup

        Network management with networkmanager-dmenu

        Brightness control with brightnessctl

        Power profiles via powerprofilesctl

        Session controls (logout, shutdown, reboot, reboot to Windows) with wlogout

    Kitty terminal configured with zsh, oh-my-zsh, Powerlevel10k, with autocompletion and autosuggestions.

    Various other scripts (screenshots, utilities, etc.) included in the config.

Installation

# Clone the repository
git clone https://github.com/<your-username>/<repo-name>.git ~/.config

# Symlink the configuration (optional)
ln -s ~/.config/<repo-name>/* ~/.config/

Usage

    Wallpaper & theme management

        Wallpapers and themes are automatically set at startup by wallpaperdaemon.

        Press SUPER+U anytime to switch wallpaper and theme with wallpaperctl.

    Waybar controls

        Network: opens networkmanager-dmenu for quick network selection.

        Brightness: adjust with Waybar buttons (uses brightnessctl).

        Power profiles: switch between profiles (performance/power-saver).

        Session menu: logout, reboot, shutdown, or reboot to Windows via wlogout.

    Terminal

        Launch Kitty with zsh (customized with Powerlevel10k, autocompletions, and autosuggestions).

    Other tools

        The config also contains extra scripts (e.g., for screenshots and more). Explore the scripts folder for details.

Credits

    Waybar layout inspired by @Rocklinks (Niri config).

    Wallpaper scripts by @OrigamingWasTaken, who also personally helped with parts of this setup.

    These dotfiles are a work in progress – feel free to fork and adapt them to your own workflow!
