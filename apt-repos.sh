#!/bin/bash

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
./clean-file.sh $1 > "Repositories.txt"

let reposNum=$(cat "Repositories.txt" | grep -E 'ppa:' | wc -l)
let zero=0

#If there is no repositories in apt-repos.conf the script will exit it.
#Else it will add the repositories to the system
if [ $reposNum == 0 ]; then
	echo "There is no repositories to add"
	exit -1

else
	while [ $reposNum -gt $zero ]; do
		for repos in $(cat Repositories.txt | grep -E 'ppa:'); do
			sudo apt-add-repository -y $repos
			let reposAux=$reposNum
			let reposNum=$reposAux-1
			echo -e
		done
	done			
fi

#Remove tmp repositories file
rm "Repositories.txt"
