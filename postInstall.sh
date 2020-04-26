#! /bin/bash

# Download the dotfiles repo.
mkdir -p Projects
cd Projects
git clone https://github.com/aklxao2/dotfiles.git .
cd ..

# Replace the config files with the new ones (create symlinks)
rm -rf ~/.i3
rm ~/.bashrc

ln -s ~/Projects/dotfiles/.i3 ~/.i3
ln -s ~/Projects/dotfiles/.bashrc ~/.bashrc


#################################
#	SOFTWARE INSTALLATION	#
#################################

# Install Font Awesome
yay -S ttf-font-awesome

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
yay -S libreoffice-fresh

# Install LaTeX, TexStudio (LaTeX Editor) and GhostScript for PDF compression
yay -S texlive-most texstudio ghostscript

# Install R and RStudio
yay -S r rstudio-desktop-bin

# Install VirtualBox
yay -S virtualbox

# Install RedShift (for adjusting monitor color temperature)
yay -S redshift redshift-gtk-git

# Install Dropbox
yay -S dropbox

# Install flatpak
yay -S flatpak
#sudo systemctl enable --now snapd.socket

# Install Spotify!
flatpak install spotify
#yay -S lib32-libcanberra-gtk3

# Install pavucontrol, equalizer and vlc and kodi
yay -S pulseaudio-equalizer-ladspa pavucontrol vlc kodi

# Install telegram
yay -S telegram-desktop

# Clean yay cache after installing all packages
yay -Sc

