#!/bin/bash

# ** UPLOAD SSH KEY TO GITHUB **
#   Info found in ./conf/ssh.conf
#   Get ssh info & GitHub username
#	Generate ssh key
# 	Upload it via 'curl' & using GitHub API

if [ $# -eq 1 ] #The file where the commands are written must be provided
then
	#Clean the comments in the ssh.conf file
	confInfo=$(. ./clean-file.sh ./conf/ssh.conf)

	#Clean the user: and email: syntax
	confInfo=$(echo "$confInfo" | sed -r -n -e 's/.*: (.*)/\1/p')

	#Generate some comments
	echo -e "\n# SSH keys are generated and added to the github account specified in the ssh.conf file" >> $1

	aux=0 #Necesary to know what is an email and what is an user

	#Extract the user and email information from ssh.conf file, generate the code needed for creating the ssh keys and upload them to github
	for x in $confInfo
	do
		let mod=$aux%2

		if [ $mod -eq 0 ]
		then
			user=$x
		else
			email=$x
			
			echo "ssh-keygen -qf "$HOME/.ssh/$user" -t rsa -C "$email" -N ''" >> $1
			echo -e "curl -u "$user" --data "{\"title\":\"\`hostname\`\",\"key\":\"\`cat $HOME/.ssh/$user.pub\`\"}" https://api.github.com/user/keys\n" >> $1
		fi

		let aux=$aux+1
	done
else
	echo "Wrong number of arguments (1 argument expected)"
fi
