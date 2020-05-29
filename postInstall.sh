#! /bin/bash

# Replace the config files with the new ones (create symlinks)
rm -rf ~/.i3
rm ~/.bashrc

# Create the symlinks to important files.
ln -s ~/Projects/dotfiles/.i3 ~/.i3
ln -s ~/Projects/dotfiles/.bashrc ~/.bashrc


# Copy the wallpaper
cp ~/Projects/dotfiles/wallpaper.jpg ~/Imágenes

# Copy the custom lockscreen
chmod +x .i3/lock.sh
sudo ln -s $HOME/.i3/lock.sh /usr/bin/customlock

#################################
#	SOFTWARE INSTALLATION	#
#################################

# Install gitflow
yay -S gitflow-avh

# Install Font Awesome and overpass font and Arc theme
yay -S ttf-font-awesome otf-overpass arc-gtk-theme ttf-ms-fonts ttf-vista-fonts 

# Install pulseaudio support
yay -S manjaro-pulse

# Install pywal (for colorschemes)
yay -S python-pywal

# Install xca (digital certificates manager)
yay -S xca

# Install RAR support
yay -S rar xarchiver

# Install blueman (for Bluetooth support)
yay -S bluez bluez-utils blueman

# Install GNOME Disk Utility (it's easier to me to handle disks this way, sorry)
yay -S gnome-disk-utility-git

# Install Firefox
yay -S firefox

# Install Java 11
yay -S jdk11-openjdk

# Install Scala and sbt
yay -S scala sbt

# Install IntelliJ Idea (Ultimate or Community)
yay -S intellij-idea-ultimate-edition    # Ultimate edition
#yay -S intellij-idea-community-edition  # Community edition

# Install Netbeans
yay -S netbeans

# Install LibreOffice
yay -S libreoffice-fresh libreoffice-fresh-es

# Install LaTeX, TexStudio (LaTeX Editor) and GhostScript for PDF compression
yay -S texlive-most texstudio ghostscript biber

# Install R and RStudio
yay -S r rstudio-desktop-bin

# Install VirtualBox
yay -S virtualbox

# Install RedShift (for adjusting monitor color temperature)
yay -S redshift redshift-gtk-git

# Install Dropbox and insync (google drive)
yay -S dropbox insync

# Install flatpak
yay -S flatpak
#sudo systemctl enable --now snapd.socket

# Install Spotify! (and playerctl for multimedia keybindings)
flatpak install spotify
yay -S playerctl
#yay -S lib32-libcanberra-gtk3

# Install pavucontrol, equalizer and vlc, kodi and pulseaudio bluetooth module
yay -S pulseaudio-equalizer-ladspa pavucontrol vlc kodi pulseaudio-modules-bt-git paprefs

# Install telegram
yay -S telegram-desktop

# Install keePass
yay -S keepass

# Install Gimp and Inkscape
yay -S gimp inkscape

# Install Rofi
yay -S rofi

# Install Polybar
yay -S polybar polybar-spotify-git

# Install Skype
yay -S skypeforlinux-stable-bin

# Install GUFW (Firewall control) and ClamTK (Antivirus)
yay -S gufw clamtk

# Install Nvidia proprietary driver
#sudo mhwd -a pci nonfree 0300

# Install Printer support
yay -S manjaro-printer hplip

# Install isw (MSI Laptop fan control)
yay -S isw

# Clean yay cache after installing all packages
yay -Sc





#################################################
#		CONFIGURATION			#
#################################################

# ENABLE NTP (for time sync)
sed "10a server hora.ujaen.es\\nserver hora2.ujaen.es\\nserver hora.rediris.es\\nserver pool.ntp.org" /etc/ntp.conf > ntp
chmod 644 ntp
sudo chown root:root ntp
sudo cp /etc/ntp.conf /etc/ntp.conf.backup
sudo cp -f ntp /etc/ntp.conf
sudo rm ntp
sudo systemctl enable --now systemd-timesyncd.service

# Adds git user name and email
git config --global user.email "agvico@ujaen.es"
git config --global user.name "Ángel Miguel García Vico"

# Add Rofi configuration
mkdir -p ~/.config/rofi
ln -s ~/Projects/dotfiles/rofi/config.rasi ~/.config/rofi/config.rasi

# Add Polybar Configuration
mkdir -p ~/.config/polybar
ln -s ~/Projects/dotfiles/polybar/config ~/.config/polybar/config
ln -s ~/Projects/dotfiles/polybar/launch.sh ~/.config/polybar/launch.sh
chmod +x ~/.config/polybar/launch.sh

# Run wal!
wal -i ~/Imágenes/wallpaper.jpg -a 95

# Modify GRUB (add the startup menu for choosing the OS)
sed "s/GRUB_TIMEOUT_STYLE=hidden/GRUB_TIMEOUT_STYLE=menu/" /etc/default/grub > newgrub
chmod 644 newgrub
sudo chown root:root newgrub
echo "Copying new GRUB..."
sudo cp -f newgrub /etc/default/grub
sudo update-grub
sudo rm newgrub

# Enable Bluetooth at startup
sudo systemctl enable bluetooth.service

# Avoid pulseaudio to increase volume higher than 100%
sudo sed "s/volume = merge/volume = ignore/" /usr/share/pulseaudio/alsa-mixer/paths/analog-output.conf.common > audio
chmod 644 audio
sudo chown root:root audio
sudo mv /usr/share/pulseaudio/alsa-mixer/paths/analog-output.conf.common /usr/share/pulseaudio/alsa-mixer/paths/analog-output.conf.common.backup
sudo cp -f audio /usr/share/pulseaudio/alsa-mixer/paths/analog-output.conf.common
sudo rm audio

# Enable pulseaudio equalizer at startup
pulseaudio-equalizer enable-config

# Switch audio source when connecting a device, e.g., a bluetooth speaker.
echo "load-module module-switch-on-connect" | sudo tee -a /etc/pulse/default.pa

# Configure printers
sudo gpasswd -a agvico sys
sudo systemctl enable --now org.cups.cupsd.service
sudo hp-setup -i
