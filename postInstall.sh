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

# Install Font Awesome and overpass font and Arc theme
yay -S ttf-font-awesome otf-overpass arc-gtk-theme 

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

# Install Spotify!
flatpak install spotify
#yay -S lib32-libcanberra-gtk3

# Install pavucontrol, equalizer and vlc, kodi and pulseaudio bluetooth module
yay -S pulseaudio-equalizer-ladspa pavucontrol vlc kodi pulseaudio-modules-bt-git

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

# Install Nvidia proprietary driver
#sudo mhwd -a pci nonfree 0300

# Clean yay cache after installing all packages
yay -Sc





#################################################
#		CONFIGURATION			#
#################################################

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
chmod 544 newgrub
sudo chown root:root newgrub
echo "Copying new GRUB..."
sudo cp -f newgrub /etc/default/grub
sudo update-grub
sudo rm newgrub

# Enable Bluetooth at startup
sudo systemctl enable bluetooth.service

# Avoid pulseaudio to increase volume higher than 100%
sudo sed "s/volume = merge/volume = ignore/" /usr/share/pulseaudio/alsa-mixer/paths/analog-output.conf.common > audio
chmod 544 audio
sudo chown root:root audio
sudo mv /usr/share/pulseaudio/alsa-mixer/paths/analog-output.conf.common /usr/share/pulseaudio/alsa-mixer/paths/analog-output.conf.common.backup
sudo cp -f audio /usr/share/pulseaudio/alsa-mixer/paths/analog-output.conf.common
sudo rm audio


