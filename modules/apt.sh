#!/bin/bash

# ** APT PACKAGE MANAGER **
#	First, adds all repos specified by the user
#		This is done calling ./modules/apt-repos
#	Reads packages name from ./conf/apt.conf & installs them

# Capture of packages in one single variable
packages=$(cat ../conf/apt.conf | grep -E '^#' -v | grep -E '^$' -v)

# iterations of sudo apt install of every single package
for i in $packages; do
	echo "sudo apt install $i"
	sudo apt install $i
done
