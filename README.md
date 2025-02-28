# Void - install Gnome-Desktop after base-install

this script is based on the script from TechGameGeek https://github.com/TechGameGeek/void/ 
and was adapted by Penguin-TV for the Gnome desktop.

YouTube channel of TechGameGeek: https://www.youtube.com/@dantechgamegeek

YouTube channel of Pinguin-TV:
https://www.youtube.com/@Pinguin-TV

Forum:
https://linux-talk.de/forum/

Requirements
Void Linux (glibc) has been installed using the base image.
The installed Void Linux has been booted.
An internet connection is available.
Initial Steps
Log into Void Linux (as a normal user).
Install git:
sudo xbps-install git
Clone the repository (as a normal user):
git clone https://github.com/pinguin-tv/void.git
Note: The repository will be cloned to ~/void.

Navigate to the directory:
cd void
Make the script executable:
chmod +x gnome_install.sh
Run the script:
./gnome_install.sh
What does the script do?
Installs Void Linux with the Cinnamon desktop environment (cinnamon-all).
Activates:
PipeWire
Printer support
Bluetooth
During installation, you will be asked whether you want to install NVIDIA drivers.
Automatically mounts drives using udisks2 & polkit, so there's no need to edit /etc/fstab.

Autostart scripts for Gnome:
Enables octoxbps-updater.
Sets the German keyboard layout (can be removed if a US layout is preferred).
Automounts all Linux filesystem drives, useful for a Steam library, for example.
Feedback
Suggestions and improvements are always welcome! 😊
