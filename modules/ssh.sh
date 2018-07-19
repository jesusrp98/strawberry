#!/bin/bash

# ** UPLOAD SSH KEY TO GITHUB **
#   Info found in ./conf/ssh.conf
#   Get ssh info & GitHub username
#	Generate ssh key
# 	Upload it via 'curl' & using GitHub API

#Clean the comments in the ssh.conf file
confInfo=$(. ./clean-file.sh ./conf/ssh.conf)

#Clean the user: and email: syntax
confInfo=$(echo "$confInfo" | sed -r -n -e 's/.*: (.*)/\1/p')

aux=0 #Necesary to know what is an email and what is an user

#Extract the user and email information from ssh.conf file, generate the ssh key and upload it to github
for x in $confInfo
do
	let mod=$aux%2

	if [ $mod -eq 0 ]
	then
		user=$x
	else
		email=$x
		
		ssh-keygen -qf "$HOME/.ssh/$user" -t rsa -C "$email" -N ''
		curl -u "$user" --data "{\"title\":\"`hostname`\",\"key\":\"`cat $HOME/.ssh/$user.pub`\"}" https://api.github.com/user/keys
	fi

	let aux=$aux+1
done
