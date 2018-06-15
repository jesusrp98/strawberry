#!/bin/bash

# Clear the screen
clear

# Internal variables for git user
hostname=$(cat /etc/hostname)
email=jesusrp98@outlook.com
user=jesusrp98

# Add git info 
echo -e "=======ADDING GIT DATA=======\n"
echo "\tUsername: $hostname"
echo "\tEmail: $email"
git config --global user.name $hostname
git config --global user.email $email

# Create & cat public RSA key
echo -e "\n=======CREATING RSA KEY & ADDING TO GITHUB======\n"
ssh-keygen -qf "$HOME/.ssh/id_rsa" -t rsa -C "$email" -N ''
curl -u "$user" --data "{\"title\":\"test-key\",\"key\":\"`cat $HOME/.ssh/id_rsa.pub`\"}" https://api.github.com/user/keys

# Clone dotfile repo from GitHub
echo -e "\n=======CLOING DOTFILES REPO & MOVING DOTFILES=======\n"
git clone git@github.com:jesusrp98/dotfiles.git $HOME
echo "\tFiles moved!"

# Install packages from pacman
echo -e "\n=======INSTALL REGULAR PACKAGES=======\n"
sudo pacman -S --noconfirm i3-gaps adapta-gtk-theme rofi ranger vim compton dunst zsh corebird telegram-desktop lxappearance redshift polkit-gnome gnome-keyring lightdm-gtk-greeter i3lock blueman playerctl pacaur lightdm-gtk-greeter python-pip sublime-text-dev

# Install packages from AUR
echo -e "\n=======INSTALL AUR PACKAGES=======\n"
pacaur -S --noconfirm --noedit polybar spotify grub-customizer oh-my-zsh-git hsetroot dunstify

# Install packages from AUR
echo -e "\n=======CHANGING DEFAULT SHELL=======\n"
chsh -s /bin/zsh