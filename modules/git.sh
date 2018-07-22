#!/bin/bash

# ** ADD GIT INFO **
#   Git info found in ./conf/git.conf
#   Add info using 'git config'

echo -e "\n# Adding Git information from user. Usefull for GitHub" >> $1

# First, gets & prints name info for Git
name=$(. ./clean-file.sh ./conf/git.conf | sed -rn -e 's/^name: (.+)$/\1/pg')
echo "git config --global user.name "$name"" >> $1

# Then, gets & prints email info for Git
email=$(. ./clean-file.sh ./conf/git.conf | sed -rn -e 's/^email: (.+)$/\1/pg')
echo "git config --global user.email $email" >> $1

# Recommended command
echo "git config --global push.default simple" >> $1
