# Void Linux Gnome or KDE Installations Script
# this script is created by https://github.com/TechGameGeek/void 
# YouTube Channel: https://www.youtube.com/@dantechgamegeek
# and customised by https://github.com/pinguin-tv/void for the desktops only

This script simplifies the installation of Void Linux with Gnome or KDE desktop environment.

## Requirements
- Void Linux (glibc) has been installed using the base image.
- The installed Void Linux has been booted.
- An internet connection is available.

## Initial Steps

1. **Log into Void Linux** (as a normal user).
2. **Install `git`**:
   ```bash
   sudo xbps-install git
   ```
3. **Clone the repository** (as a normal user):
   ```bash
   git clone https://github.com/pinguin-tv/void.git
   ```
   > *Note:* The repository will be cloned to `~/void`.
4. **Navigate to the directory**:
   ```bash
   cd void
   > please choose your desktop
   ```
5. **Make the script executable**:
   ```bash
   please choose your desktop
    > *Note:* for Gnome "gnome_install.sh".
   chmod +x gnome_install.sh
   
   > *Note:* for Kde "kde_install.sh".
   chmod +x kde_install.sh
   ```
6. **Run the script**:
   ```bash
   ./gnome_install.sh or ./kde_install.sh
   ```

## What does the script do?
- Installs Void Linux with the Gnome or KDE desktop environment (`gnome-core`).
- Activates:
  - PipeWire
  - Printer support
  - Bluetooth
- During installation, you will be asked whether you want to install NVIDIA drivers (from latest to older versions).
- Automatically mounts drives using `udisks2` & `polkit`, so there's no need to edit `/etc/fstab`.
- Customizations:
  - Cinnamon and LightDM background images are modified.
  - Autostart scripts for Cinnamon:
    - **Enables `octoxbps-updater`**.
    - **Automounts all Linux filesystem drives**, useful for a Steam library, for example.

## Feedback
Suggestions and improvements are always welcome! 😊
