#!/bin/bash

# ** ADD GIT INFO **
#   Git info found in ./conf/git.conf
#   Add info using 'git config'

name=$(. ./clean-file.sh ./conf/git.conf | sed -rn -e 's/^name: (.+)$/\1/pg')
echo "git config --global user.name "$name"" >> $1

email=$(. ./clean-file.sh ./conf/git.conf | sed -rn -e 's/^email: (.+)$/\1/pg')
echo "git config --global user.email $email" >> $1

echo "git config --global push.default simple" >> $1
