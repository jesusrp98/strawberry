#!/bin/bash

# ** GITHUB REPO CLONING **
#   Repos to clone in ./conf/repos.conf
#   Check where to clone them
#	If path is not provided, clone them in /home/$USER/Documents

if [ $# -eq 1 ] 
then
	#Clean the comments in the repos.conf file
	confInfo=$(./clean-file.sh ./conf/repos.conf)
	
	#Divides the information with a path defined or not in confInfo
	withArg=$(echo "$confInfo" | grep '^.*\ .*$') 
	noArg=$(echo "$confInfo" | grep -v '^.*\ .*$')

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
		fi

		let aux=$aux+1
	done

	for x in $noArg
	do
		echo "git clone $x /home/$USER/Documents/$(basename $x | sed -r -e 's/(.*)\.git/\1/')" >> $1
	done

else
	echo "Wrong number of arguments (1 argument expected)"
fi

