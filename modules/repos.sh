#!/bin/bash

# ** GITHUB REPO CLONING **
#   Repos to clone in ./conf/repos.conf
#   Check where to clone them
#	If path is not provided, clone them in /home/$USER/Documents

if [ $# -eq 1 ] 
then
	confInfo=$(cat ../conf/repos.conf | grep -v '^#.*' | grep ^[^\ ] | grep -v "$(printf '\t')") #Reads information from /conf/repos.conf
	
	#Divides the information with a path defined or not in confInfo
	withArg=$(echo "$confInfo" | grep '^.*\ .*$') 
	noArg=$(echo "$confInfo" | grep -v '^.*\ .*$')

	if [ -e $1 ] #If the file given already exist, it is deleted
	then
		rm $1
	fi

	aux=0 #Necesary to separate the de repository link from the path

	#Creates and fill the git clone command file and clones the repositories
	for x in $withArg
	do
		let mod=$aux%2

		if [ $mod -eq 0 ]
		then
			line="$x"
		else
			line="$line $x"
			echo "git clone $line" >> $1
			git clone $line
		fi

		let aux=$aux+1
	done

	for x in $noArg
	do
		echo "git clone $x /home/$USER/Documents/$(basename $x | sed -r -e 's/(.*)\.git/\1/')" >> $1
		git clone $x /home/$USER/Documents/$(basename $x | sed -r -e 's/(.*)\.git/\1/')
	done

else
	echo "Wrong number of arguments (1 argument expected)"
fi

