#!/bin/bash

# ** GENERATE LINKS **
#	Links to generate & type found in ./conf/links.conf
#   Generate link from a specific file
#	Check link type & path

if [ $# -eq 1 ] 
then
    #Clean the comments in the links.conf file
	confInfo=$(. ./clean-file.sh ./conf/links.conf)

    #Generate some comments
	echo -e "\n# Creates soft or hard links to files in a path" >> $1

	#Soft and hard links are clasified
	hardLinks=$(echo "$confInfo" | grep "^.* hard .*$")
	softLinks=$(echo "$confInfo" | grep "^.* soft .*$")

	aux=0 #Necesary to read the arguments given in the links.conf file

	#Generates the code for the creation of the hard links specified en the links.conf file
	echo -e "# Hard links" >> $1

	for hardLink in $hardLinks
	do
		if [ $aux -eq 0 ]
		then
			origen=$hardLink
		fi 

		if [ $aux -eq 2 ]
		then
			echo "ln $origen $x" >> $1
			aux=-1
		fi 

		let aux=$aux+1
	done

	#Generates the code for the creation of the soft links specified en the links.conf file
	echo -e "# Soft links" >> $1

	for softLink in $softLinks
	do
		if [ $aux -eq 0 ]
		then
			origen=$softLink
		fi 

		if [ $aux -eq 2 ]
		then
			echo "ln -s $origen $x" >> $1
			aux=-1
		fi 

		let aux=$aux+1
	done

else
	echo "Wrong number of arguments (1 argument expected)"
fi
