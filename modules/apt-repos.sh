#!/bin/bash

# ** ADD APT REPOS **
#	Reads ./conf/apt-repos.conf & adds all those repos
#		Do this before apt install

#Check if there is an argument and if it exists must be a file
if [ -z $1 ]; then
	echo "Missed argument"
	exit -1
fi

if [ ! -f $1 ]; then
	echo "Argument is not a file"
	exit -1
fi

#This will clean the apt-repos.conf file and it will create a new one to work with
repos=$(. ./clean-file.sh ./conf/apt-repos.conf) >> $1

for repo in $repos; do
    echo "sudo apt-add-repository -y $repo" >> $1
done			
