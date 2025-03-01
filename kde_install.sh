#!/bin/bash
#diese Script ist von TechGameGeek entwickelt und von Pinguin-TV für den KDE-Desktop angepasst!
#https://www.youtube.com/@dantechgamegeek
#https://github.com/TechGameGeek/void
#Das Skript ist für NVIDIA-GPU Besitzer gedacht / AMD GPU Besitzer kommentieren die Zeile mit der NVIDIA Paketinstallation aus!
#This script is intended to be used by NVIDIA-GPU Owners, you may comment the line with
#sudo xbps-install -y nvidia if you have an AMD-GPU
#Void aktualisieren / update void

#Setze Keyboardlayout de-latin1 / Set keyboard de-latin1 (if you don't want DE-key comment out this line)
#loadkeys de-latin1

#Das folgende Skript ist für die Installation von Gnome & div. Dienste gedacht, nachdem die Basisinstallation durchgefuehrt worden ist!
#The following script is for installing Gnome & Services after installing base-void (glibc)

#bash starten & bash für root setzen / start bash - set for root
clear
echo "Setze Rootshell auf /bin/bash / set rootshell to /bin/bash"
echo "Bitte Rootpasswort eingeben / Please give rootpassword"
su -c "chsh -s /bin/bash root"
sleep 2

#Sudo einrichten / Activate sudo
clear
echo "Aktiviere sudo für Gruppe wheel / Activate sudo for wheel-group"
echo "Bitte Rootpasswort eingeben / Please give rootpassword"
su -c 'echo "%wheel ALL=(ALL:ALL) ALL" | tee -a /etc/sudoers > /dev/null'
sleep 2

#Styling
clear
echo "Richte Plasma Hintergrundbild ein / Setting up Plasma backgroundimage"
echo " -- Bitte unten das sudo Passwort eingeben / Please give sudo-password -- "
sudo mkdir -p /usr/share/plasma/wallpapers/
sudo cp ~/void/1440-VCF-1.jpg /usr/share/plasma/wallpapers/


#Systemupdate checken / Check systemupdates
sudo xbps-install -Syu

#void zusätzliche Repos aktivieren / activate all essential Repos
clear
echo "Nonfree, multilib, multilib-nonfree aktivieren / Activate all essential additional repos"
sudo xbps-install -y void-repo-nonfree void-repo-multilib void-repo-multilib-nonfree vsv 
sleep 2

#Voidrepo aktualisieren / update voidrepository
sudo xbps-install -Syu

#Editor installieren / Install editor
clear
echo "Install nano..."
sudo xbps-install -y nano
sleep 1

#Netzwerk/Network
clear
echo "Install NetworkManager"
sudo xbps-install -y NetworkManager NetworkManager-openvpn NetworkManager-openconnect NetworkManager-vpnc NetworkManager-l2tp network-manager-applet ntp wpa_supplicant linux-firmware-network
sudo ln -s /etc/sv/NetworkManager /var/service/
sleep 1

#dbus
clear
echo "Install dbus..."
sudo xbps-install -y dbus
sudo ln -s /etc/sv/dbus /var/service/
sleep 1

#elogind
clear
echo "Install elogind..."
sudo xbps-install -y elogind
sudo ln -s /etc/sv/elogind /var/service/
sleep 1

#Audio/bluetooth/Mixer
clear
echo "Install pipewire, wireplumber, pavucontrol, pulsemixer"
sudo xbps-install -y pipewire wireplumber pavucontrol pulsemixer libspa-bluetooth alsa-utils paprefs alsa-pipewire alsa-ucm-conf gstreamer1-pipewire libpipewire
sleep 1

#NVIDIA Treiber installieren / Install NVIDIA-driver
clear
read -p "NVIDIA-Treiber installieren / Install Nvidia-driver? (1 = Ja/Yes, 0 = Nein/No): " auswahl
if [ "$auswahl" -eq 1 ]; then
    echo "Installiere NVIDIA-Treiber / Installing NVIDIA..."
    sudo xbps-install -y nvidia nvidia-libs-32bit
else
    echo "NVIDIA-Setup übersprungen / NVIDIA skipped."
fi
sleep 1

#Steamkomponenten / Install some Steam-related-Stuff
sudo xbps-install -y libgcc-32bit libstdc++-32bit libdrm-32bit libglvnd-32bit mesa-dri-32bit

#XORG & Gnome & Tools
clear
echo "Install XORG/KDE..."
sudo xbps-install -y xorg xorg-input-drivers xorg-video-drivers setxkbmap xauth xrandr
sudo xbps-install -y octoxbps kde5 kde5-baseapps kdesu xdg-desktop-portal xdg-desktop-portal-gtk xdg-user-dirs xdg-user-dirs-gtk xdg-desktop-portal-wlr xdg-utils xdg-desktop-portal-kde gnome-keyring wget curl bash-completion libva-vdpau-driver vdpauinfo curl ffmpeg mesa-vdpau mesa-vaapi autoconf automake bison m4 make libtool linux-headers dialog dkms ark konsole rsync
sleep 1

#Druckerunterstuetzung / Printersupport
clear
echo "Install Printer..."
sudo xbps-install -y cups cups-filters gutenprint cups-pk-helper bluez-cups system-config-printer
sudo ln -s /etc/sv/cupsd /var/service/
sudo xbps-install -y users-admin
sleep 1

#Filesystem
clear
echo "Install Zusatztools/Installing additional tools..."
sudo xbps-install -y exfat-utils fuse-exfat gvfs-afc gvfs-mtp gvfs-smb udisks2 ntfs-3g gptfdisk bluez AppStream libva-vdpau-driver vdpauinfo autofs gptfdisk dialog cryptsetup lvm2 mdadm dbus avahi avahi-utils libxcrypt-compat gnome-disk-utility inetutils usbutils gst-plugins-ugly1 kaccounts-integration kaccounts-providers dolphin dolphin-plugins plasma-nm numlockx kdeconnect amberol spectacle plasma-pa tinc kcalc
#Aktiviere bluetoothd/activate bluetoothd
sudo ln -s /etc/sv/bluetoothd /var/service/
sleep 1

#Flatpak / Upgradetool
clear
echo "Install Flatpak / topgrade..."
sudo xbps-install -y flatpak topgrade tlp tlpui
sleep 1

#Fonts
clear
echo "Install Fonts..."
sudo xbps-install -y noto-fonts-cjk noto-fonts-emoji noto-fonts-ttf noto-fonts-ttf-extra font-misc-misc terminus-font dejavu-fonts-ttf
sleep 1

#Software
clear
echo "Install Software..."
sudo xbps-install -y firefox firefox-i18n-de tumbler 
sleep 1
# Erstelle ein Skript, das die gsettings nach der Anmeldung ausführt
echo "Creating autostart script for gnome theme settings..."
cat <<EOL > /home/$USER/set-gnome-theme.sh
#!/bin/bash
# Setze das gewünschte Cinnamon-Theme & deutsches Tastaturlayout
gsettings set org.plasma.desktop.interface icon-theme breeze-dark
gsettings set org.plasma.desktop.interface plasma-theme breeze-dark
gsettings set org.plasma.theme name Breeze-Dark
gsettings set org.plasma.desktop.input-sources sources "[('xkb', 'de')]"
gsettings set org.plasma.desktop.interface monospace-font-name 'Monospace 11'
gsettings set org.plasma.desktop.background picture-uri 'file:///usr/share/plasma/wallpapers/1440-VCF-1.jpg'


# Lösche den Autostart-Eintrag nach der ersten Ausführung
rm -f ~/.config/autostart/set-plasma-theme.desktop

# Gib eine Nachricht aus, dass das Skript abgeschlossen ist
echo "Kde-Themes wurden gesetzt und Autostart-Eintrag entfernt."
EOL

# Stelle sicher, dass das Skript ausführbar ist
chmod +x /home/$USER/set-plasma-theme.sh

# Erstelle die Autostart-Datei, die das Skript ausführt
mkdir -p ~/.config/autostart
cat <<EOL > ~/.config/autostart/set-plasma-theme.desktop
[Desktop Entry]
Type=Application
Exec=/home/$USER/set-plasma-theme.sh
Name=Set KDE Theme
Comment=Set the default Plasma theme after login
X-GNOME-Autostart-enabled=true
EOL

# .desktop-Datei für octoxbps-notifier erstellen / create .desktopfile für octoxbps-notifier
cat > ~/.config/autostart/octoxbps-notifier.desktop <<EOL
[Desktop Entry]
Type=Application
Exec=/bin/octoxbps-notifier
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name=OctoXBPS Notifier
Comment=Startet OctoXBPS Update Notifier automatisch
EOL

# .desktop-Datei für deutsche Tastatur / create .desktopfile für german-X11-keyboard
# Bitte Autostarteintrag in Gnome deaktivieren wenn ihr es direkt in Cinnamon setzen wollt
# Please remove this autostart-entry if you would like to set the keyboardlayout directly in hde
cat > ~/.config/autostart/x11kb-german.desktop <<EOL
[Desktop Entry]
Type=Application
Exec=/usr/bin/setxkbmap de
Hidden=false
NoDisplay=false
X-Plasma-Autostart-enabled=true
Name=X11-KB-German
Comment=Deutsche Tastatur aktivieren unter X11
EOL


# Weiter mit weiteren Installationen oder zum Ende des Skripts
echo "Plasma-Theme Autostart-Skript erstellt. Skript beendet."

#Loginmanager
clear
echo "Install SDDM..."
sudo xbps-install -y sddm sddm-kcm
sudo ln -s /etc/sv/sddm/ /var/service/
sudo ln -s /etc/sv/polkitd/ /var/service/
sleep 1

#Virt-Manager
clear
echo "Install Virt-Manager..."
sudo xbps-install -y qemu libvirt virt-manager virt-manager-tools
sudo ln -s /etc/sv/libvirtd/ /var/service/
sudo ln -s /etc/sv/virtlockd/ /var/service/
sudo ln -s /etc/sv/virtlogd/ /var/service/
sleep 1

#Gnome-Themes
clear
echo "Install Theme / Icons / Codecs..."
sudo xbps-install -y arc-icon-theme arc-theme adwaita-icon-theme adapta-kde papirus-icon-theme ocs-url x264 x265 ffmpeg
sleep 1

#Setup Autostart - pipewire & wireplubmer

sudo mkdir -p /etc/pipewire/pipewire.conf.d

sudo ln -s /usr/share/examples/wireplumber/10-wireplumber.conf /etc/pipewire/pipewire.conf.d/
sudo ln -s /usr/share/examples/pipewire/20-pipewire-pulse.conf /etc/pipewire/pipewire.conf.d/
sudo ln -s /usr/share/applications/pipewire.desktop /etc/xdg/autostart/
sleep 1
clear
#Deutsche Tastatur aktivieren X11 / Activate german keyboard for X11
echo "de_DE" > "$HOME/.config/user-dirs.locale"

#Setup automount ssd/hdd - ohne fstab / setup automount for ssds/hdds - without fstab
sudo cp ~/void/10-mount-drives.rules /etc/polkit-1/rules.d/
clear
echo "Setupscript beendet - System kann nun neu gestartet werden / Setup finished - please reboot"
echo "sudo reboot verwenden - use sudo reboot"
