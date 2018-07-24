#!/bin/bash

# MADE BY CARLOS LUQUE

# ** ADD APT REPOS **
#	Reads ./conf/apt-repos.conf & adds all those repos
#   Do this before 'apt install'

# First, we clean the config file to get the repos
repos=$(. ./clean-file.sh ./conf/apt-repos.conf) >> $1

echo -e "\n# Adding neccesary repositories to APT package manager" >> $1

# Then, prints the commands to $1
for repo in $repos; do
    echo "sudo apt-add-repository -y $repo" >> $1
done			
