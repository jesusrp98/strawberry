#!/bin/bash

# ** APT PACKAGE MANAGER **
#	First, adds all repos specified by the user
#	This is done calling ./modules/apt-repos
#	Reads packages name from ./conf/apt.conf & installs them

# Capture of packages in one single variable
packages=$(. ./clean-file.sh ./conf/apt.conf)

echo -e "\n# Installing packages via APT" >> $1

# Iterations of sudo apt install of every single package
printf "sudo apt install" >> $1

for package in $packages; do
	printf " $package" >> $1
done

echo >> $1
