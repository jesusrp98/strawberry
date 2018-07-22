#!/bin/bash

# ** APT PACKAGE MANAGER **
#	First, adds all repos specified by the user
#		This is done calling ./modules/apt-repos
#	Reads packages name from ./conf/apt.conf & installs them

# Capture of packages in one single variable
packages=$(. ./clean-file.sh ./conf/apt.conf)

# iterations of sudo apt install of every single package
printf "sudo apt install" >> $1
for i in $packages; do
	printf " $i" >> $1
done
echo >> $1
