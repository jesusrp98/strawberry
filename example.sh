#!/bin/bash

# Clear the screen
clear

# Variables for Git user
hostname=$(cat /etc/hostname)
email=jesusrope98@outlook.com
user=jesusrp98

# Add Git info 
echo -e "=======ADDING GIT DATA=======\n"
echo -e "\tUsername: $hostname"
echo -e "\tEmail: $email"
git config --global user.name $hostname
git config --global user.email $email
echo -e "\tUser info added!"

# Create & cat public RSA key
echo -e "\n=======CREATING SSH KEY & ADDING IT TO GITHUB======\n"
ssh-keygen -qf "$HOME/.ssh/id_rsa" -t rsa -C "$email" -N ''
curl -u "$user" --data "{\"title\":\"test-key\",\"key\":\"`cat $HOME/.ssh/id_rsa.pub`\"}" https://api.github.com/user/keys
echo -e "\tSSH key added to GitHub!"

# Clone dotfile repo from GitHub
echo -e "\n=======CLOING DOTFILES REPO=======\n"
mkdir $HOME/.dotfiles
git clone git@github.com:jesusrp98/dotfiles.git $HOME/.dotfiles
echo -e "\tRepo cloned!"

# Install packages from pacman
echo -e "\n=======INSTALL REGULAR PACKAGES=======\n"
sudo pacman -S --noconfirm i3-gaps adapta-gtk-theme rofi ranger vim compton dunst zsh corebird telegram-desktop lxappearance redshift polkit-gnome gnome-keyring lightdm-gtk-greeter i3lock blueman playerctl pacaur lightdm-gtk-greeter python-pip vlc termite
echo -e "\tPacman packages installed!"

# Install packages from AUR
echo -e "\n=======INSTALL AUR PACKAGES=======\n"
pacaur -S --noconfirm --noedit polybar spotify grub-customizer oh-my-zsh-git hsetroot dunstify sublime-text-dev light
echo -e "\tAUR packages installed!"

# Change shell
echo -e "\n=======CHANGING DEFAULT SHELL=======\n"
chsh -s /bin/zsh
echo -e "\tShell changed!"

# Create links
echo -e "\n=======CREATING SOFT LINKS=======\n"
mkdir $HOME/.fonts
mkdir $HOME/.config/termite
cp $HOME/.dotfiles/fonts/* $HOME/.fonts
ln -s $HOME/.dotfiles/vim/vimrc $HOME/.vimrc
ln -s $HOME/.dotfiles/zsh/.zshrc $HOME/.zshrc
ln -s $HOME/.dotfiles/termite/config $HOME/.config/termite/config
rm $HOME/.config/i3/config
ln -s $HOME/.dotfiles/i3/config $HOME/.config/i3/config
echo -e "\tLinks created!"

# Update Lightdm config file
echo -e "\n=======CHANGING LIGHTDM CONFIG=======\n"
sudo sed -i 's/^greeter-session=.*/greeter-session=lightdm-gtk-greeter/' /etc/lightdm/lightdm.conf
echo -e "\tLightdm config changed!"

# Update Grub2 config file if XPS
if [ "$hostname" == "LINUX-XPS" ]; then
    echo -e "\n=======CHANGING GRUB CONFIG=======\n"
    sudo sed -i '/^GRUB_THEME=.*/d' /etc/default/grub
    sudo grub-mkconfig -o /boot/grub/grub.cfg
    echo -e "\tGrub2 config changed!"
fi

# Update sudo config file
echo -e "\n=======CHANGING SUDO CONFIG=======\n"
sudo echo "jesus ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/10-installer
echo -e "\tSudo config changed!"

# Config NZXT Kraken daemon
sudo python3 -m pip install krakenx
echo -e "\tKrakenx installed!"

# Change default editor
export EDITOR=vim
