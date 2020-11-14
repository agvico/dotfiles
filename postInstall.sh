#! /bin/bash

# Replace the config files with the new ones (create symlinks)
rm -rf ~/.i3
rm ~/.bashrc
rm ~/.Xresources

# Create the symlinks to important files.
mkdir -p ~/Projects/dotfiles

# Copy the wallpaper
cp ~/Projects/dotfiles/wallpaper.jpg ~/Imágenes

# Copy the custom lockscreen
chmod +x .i3/lock.sh
sudo ln -s $HOME/.i3/lock.sh /usr/bin/customlock

#################################
#	SOFTWARE INSTALLATION	#
#################################

yay -S gitflow-avh ttf-font-awesome otf-overpass arc-gtk-theme orchis-theme-git ttf-ms-fonts ttf-vista-fonts ttf-cascadia-code manjaro-pulse python-pywal xca unzip zip rar xarchiver bluez bluez-utils blueman gnome-disk-utility-git firefox python-pywalfox jdk11-openjdk scala sbt intellij-idea-ultimate-edition netbeans libreoffice-fresh libreoffice-fresh-es texlive-most texstudio ghostscript biber r rstudio-desktop-bin virtualbox redshift redshift-gtk-git insync flatpak playerctl pulseaudio-equalizer-ladspa pavucontrol vlc kodi pulseaudio-modules-bt-git paprefs kdenlive telegram-desktop keepassxc gimp inkscape rofi polybar polybar-spotify-git skypeforlinux-stable-bin gufw clamtk manjaro-printer hplip isw autofirma neofetch exa spicetify-cli spicetify-themes-git thunar thunar-archive-plugin

# Clean yay cache after installing all packages
yay -Sc

# Install Spotify (via flatpak)
flatpak install spotify

# Install Nvidia proprietary driver
sudo mhwd -a pci nonfree 0300

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

# Adds polybar modules
cd ~/.config/polybar
curl -LO https://github.com/vyachkonovalov/polybar-gmail/archive/master.tar.gz
tar zxf master.tar.gz && rm master.tar.gz
mv polybar-gmail-master gmail
~/.config/polybar/gmail/auth.py # Runs the script
cd ~

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

# Enable bluetooth adapters at startup
echo "AutoEnable=true" | sudo tee -a /etc/bluetooth/main.conf

# Configure printers
sudo gpasswd -a agvico sys
sudo systemctl enable --now org.cups.cupsd.service
sudo hp-setup -i

#Configure pywalfox
sudo chmod +x /usr/lib/python3.8/site-packages/pywalfox/bin/main.sh
sudo pywalfox setup

#Configure Spicetify (Spotify customization. NOTE: Installed from flatpak!)
ln -s ~/Projects/dotfiles/spicetify/config.ini ~/.config/spicetify/config.ini
sudo chmod a+wr /var/lib/flatpak/app/com.spotify.Client/current/active/files/extra/share/spotify
sudo chmod a+wr -R /var/lib/flatpak/app/com.spotify.Client/current/active/files/extra/share/spotify/Apps/

spicetify
spicetify backup apply enable-devtool
spicetify update
SPOTIFY_THEME="ShadowCustom"
picetify config current_theme $SPOTIFY_THEME
spicetify config extensions "queueAll.js|djMode.js|shuffle+.js|fullAppDisplay.js"
spicetify apply

# Configure Firefox (https://github.com/dbuxy218/Prismatic-Night#userchrome)
#sudo cp ~/.mozilla/firefox/newpage/mozilla.cfg /usr/lib/firefox
#sudo cp ~/.mozilla/firefox/newpage/local-settings.js /usr/lib/firefox/defaults/pref/


#symlinks to important files
ln -s ~/Projects/dotfiles/.i3 ~/.i3
ln -s ~/Projects/dotfiles/.bashrc ~/.bashrc
ln -s ~/Projects/dotfiles/.Xresources .Xresources

# Restore crontab
crontab cron-backup

