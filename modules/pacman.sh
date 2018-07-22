#!/bin/bash

# ** ARCH PACKAGES **
#	Installs regular Arch packages (from pacman)
#	Packages to install found in ./conf/pacman.conf

# Get list of packages to install
packages=$(. ./clean-file.sh ./conf/pacman.conf)

echo -e "\n# Installing packages via PACMAN" >> $1

# Prints command to install all packages
printf "sudo pacman -S" >> $1
for package in $packages; do
    printf " $package" >> $1
done

echo >> $1
