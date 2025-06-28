#!/bin/bash
#diese Script ist von TechGameGeek entwickelt und von Pinguin-TV für den Gnome-Desktop angepasst!
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
echo "Richte Gnome Hintergrundbild ein / Setting up Gnome backgroundimage"
echo " -- Bitte unten das sudo Passwort eingeben / Please give sudo-password -- "
sudo mkdir -p /usr/share/backgrounds/
sudo cp ~/void/wallpaper/111.jpg /usr/share/backgrounds/
sudo cp ~/void/wallpaper/112.jpg /usr/share/backgrounds/
sudo cp ~/void/wallpaper/113.jpg /usr/share/backgrounds/
sudo mkdir -p /usr/share/gnome-background-properties/
sudo cp ~/void/wallpaper/111.xml /usr/share/gnome-background-properties/
sudo cp ~/void/wallpaper/112.xml /usr/share/gnome-background-properties/
sudo cp ~/void/wallpaper/113.xml /usr/share/gnome-background-properties/
#lightdm-Anpassung
sudo mkdir -p /etc/lightdm/
sudo cp ~/void/lightdm/lightdm.conf /etc/lightdm/
sudo cp ~/void/lightdm/lightdm-gtk-greeter.conf /etc/lightdm/
#Extensions
#sudo mkdir -p /usr/share/gnome-shell/
#sudo mkdir -p /usr/share/gnome-shell/extensions/
#sudo cp ~/void/extensions/appindicatorsupport@rgcjonas.gmail.com /usr/share/gnome-shell/extensions/
#sudo cp ~/void/extensions/azclock@azclock.gitlab.com /usr/share/gnome-shell/extensions/
#sudo cp ~/void/extensions/blur-my-shell@aunetx /usr/share/gnome-shell/extensions/
#sudo cp ~/void/extensions/compiz-alike-magic-lamp-effect@hermes83.github.com /usr/share/gnome-shell/extensions/
#sudo cp ~/void/extensions/compiz-windows-effect@hermes83.github.com /usr/share/gnome-shell/extensions/
#sudo cp ~/void/extensions/ControlBlurEffectOnLockScreen@pratap.fastmail.fm /usr/share/gnome-shell/extensions/
#sudo cp ~/void/extensions/dash-to-dock@micxgx.gmail.com /usr/share/gnome-shell/extensions/
#sudo cp ~/void/extensions/formatter@marcinjakubowski.github.com /usr/share/gnome-shell/extensions/
#sudo cp ~/void/extensions/desktop-cube@schneegans.github.com /usr/share/gnome-shell/extensions/
#sudo cp ~/void/extensions/drive-menu@gnome-shell-extensions.gcampax.github.com /usr/share/gnome-shell/extensions/
#sudo cp ~/void/extensions/extension-list@tu.berry /usr/share/gnome-shell/extensions/
#sudo cp ~/void/extensions/reboottouefi@ubaygd.com /usr/share/gnome-shell/extensions/
#sudo cp ~/void/extensions/transparent-top-bar@ftpix.com /usr/share/gnome-shell/extensions/
#sudo cp ~/void/extensions/user-theme@gnome-shell-extensions.gcampax.github.com /usr/share/gnome-shell/extensions/
#Grub-Menu
sudo mkdir -p /etc/default/
sudo cp ~/void/Grub-Menu/default/grub /etc/default/
sudo mkdir -p /etc/modeprobe.d/
sudo cp ~/void/Grub-Menu/default/modeprobe.d/blacklist.conf /etc/modeprobe.d/



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
sudo xbps-install -y NetworkManager NetworkManager-openvpn NetworkManager-openconnect NetworkManager-vpnc NetworkManager-l2tp network-manager-applet ntp wpa_supplicant
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
echo "Install elogind/avahi..."
sudo xbps-install -y elogind avahi avahi-utils cronie
sudo ln -s /etc/sv/elogind /var/service/
sudo ln -s /etc/sv/avahi-daemon /var/service/
sudo ln -s /etc/sv/cronie /var/service/
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
echo "Install XORG/Gnome-cor..."
sudo xbps-install -y xorg xorg-input-drivers xorg-video-drivers setxkbmap xauth xrandr
sudo xbps-install -y octoxbps gnome-core xdg-desktop-portal xdg-desktop-portal-gtk xdg-user-dirs xdg-user-dirs-gtk xdg-desktop-portal-wlr xdg-utils xdg-desktop-portal-kde gnome-keyring sushi wget bash-completion libva-vdpau-driver vdpauinfo curl ffmpeg mesa-vdpau mesa-vaapi autoconf automake bison m4 make libtool linux-headers extension-manager chrome-gnome-shell os-prober file-roller
sleep 1

#Druckerunterstuetzung / Printersupport
clear
echo "Install Printer..."
sudo xbps-install -y cups cups-filters gutenprint cups-pk-helper bluez-cups iscan-data nss-mdns system-config-printer epson-inkjet-printer-escpr hplip brother-brlaser foomatic-db foomatic-db-engine
sudo ln -s /etc/sv/cupsd /var/service/
sudo xbps-install -y gnome-system-tools users-admin
sleep 1

#Filesystem
clear
echo "Install Zusatztools/Installing additional tools..."
sudo xbps-install -y exfat-utils fuse-exfat gvfs-afc gvfs-mtp gvfs-smb udisks2 ntfs-3g gptfdisk bluez AppStream libva-vdpau-driver vdpauinfo autofs gptfdisk dialog cryptsetup lvm2 mdadm dbus avahi avahi-utils libxcrypt-compat gnome-disk-utility gnome-bluetooth numlockx gedit gedit-plugins
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
sudo xbps-install -y firefox firefox-i18n-de gnome-terminal nautilus-gnome-terminal-extension tumbler gnome-tweaks
sleep 1
# Erstelle ein Skript, das die gsettings nach der Anmeldung ausführt
echo "Creating autostart script for gnome theme settings..."
cat <<EOL > /home/$USER/set-gnome-theme.sh
#!/bin/bash
# Setze das gewünschte Cinnamon-Theme & deutsches Tastaturlayout
gsettings set org.gnome.desktop.interface icon-theme Papirus
gsettings set org.gnome.desktop.interface gtk-theme Arc-Dark
gsettings set org.gnome.theme name Arc-Dark
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'de')]"
gsettings set org.gnome.desktop.interface monospace-font-name 'Monospace 11'
gsettings set org.gnome.desktop.background picture-uri 'file:///usr/share/backgrounds/112.jpg'


# Lösche den Autostart-Eintrag nach der ersten Ausführung
rm -f ~/.config/autostart/set-gnome-theme.desktop

# Gib eine Nachricht aus, dass das Skript abgeschlossen ist
echo "Gnome-Themes wurden gesetzt und Autostart-Eintrag entfernt."
EOL

# Stelle sicher, dass das Skript ausführbar ist
chmod +x /home/$USER/set-gnome-theme.sh

# Erstelle die Autostart-Datei, die das Skript ausführt
mkdir -p ~/.config/autostart
cat <<EOL > ~/.config/autostart/set-gnome-theme.desktop
[Desktop Entry]
Type=Application
Exec=/home/$USER/set-gnome-theme.sh
Name=Set Gnome Theme
Comment=Set the default Gnome theme after login
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
# Please remove this autostart-entry if you would like to set the keyboardlayout directly in Cinnamon
cat > ~/.config/autostart/x11kb-german.desktop <<EOL
[Desktop Entry]
Type=Application
Exec=/usr/bin/setxkbmap de
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name=X11-KB-German
Comment=Deutsche Tastatur aktivieren unter X11
EOL


# Weiter mit weiteren Installationen oder zum Ende des Skripts
echo "Gnome-Theme Autostart-Skript erstellt. Skript beendet."

#Loginmanager
clear
echo "Install Lightdm..."
sudo xbps-install -y lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings
sudo ln -s /etc/sv/lightdm/ /var/service/
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
echo "Install Theme / Icons /Codecs..."
sudo xbps-install -y arc-icon-theme arc-theme Adapta papirus-icon-theme adwaita-icon-theme ocs-url x264 x265 ffmpeg
sleep 1

# Füge die gewünschten Einstellungen zur LightDM-Konfiguration hinzu
echo "theme-name=Arc-Dark" | sudo tee -a /etc/lightdm/lightdm-gtk-greeter.conf > /dev/null
echo "icon-theme-name=Arc" | sudo tee -a /etc/lightdm/lightdm-gtk-greeter.conf > /dev/null
echo "background=/usr/share/backgrounds/112.jpg" | sudo tee -a /etc/lightdm/lightdm-gtk-greeter.conf > /dev/null
#echo "indicators = ~host;~spacer;~clock;~spacer;~layout;~session;~a11y;~power" | sudo tee -a /etc/lightdm/lightdm-gtk-greeter.conf > /dev/null 
#echo "greeter-setup-script=/usr/bin/numlockxon" | sudo tee -a /etc/lightdm/lightdm.conf > /dev/null
#echo "display-setup-script=setxkbmap de" | sudo tee -a /etc/lightdm/lightdm.conf > /dev/null

#Setup Autostart - pipewire & wireplubmer

sudo mkdir -p /etc/pipewire/pipewire.conf.d

sudo ln -s /usr/share/examples/wireplumber/10-wireplumber.conf /etc/pipewire/pipewire.conf.d/
sudo ln -s /usr/share/examples/pipewire/20-pipewire-pulse.conf /etc/pipewire/pipewire.conf.d/

#folgende Zeile nicht auskommetieren sonst läuft pipewire nicht / do not activate the following line. pipewire stops working if so!
#sudo ln -s /usr/share/applications/wireplumber.desktop /etc/xdg/autostart/
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
