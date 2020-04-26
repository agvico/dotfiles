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

# Install Firefox
yay -S firefox

# Install Java 11
yay -S jdk11-openjdk

# Install IntelliJ Idea (Ultimate or Community)
yay -S intellij-idea-ultimate-edition    # Ultimate edition
#yay -S intellij-idea-community-edition  # Community edition

# Install Netbeans
yay -S netbeans

# Install LibreOffice
yay -S libreoffice-fresh

# Install LaTeX, TexStudio (LaTeX Editor) and GhostScript for PDF compression
yay -S texlive-most texstudio ghostscript

