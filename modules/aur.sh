#!/bin/bash

# ** AUR PACKAGES **
#	Installs AUR packages for Arch Linux
#	Reads packages names from ./conf/aur.conf

# Get list of packages to install
packages=$(. ./clean-file.sh ./conf/aur.conf)

echo -e "\n# Installing packages via PACAUR" >> $1

# Prints command to install all packages
printf "pacaur -S" >> $1
for package in $packages; do
    printf " $package" >> $1
done

echo >> $1
