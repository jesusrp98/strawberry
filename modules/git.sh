#!/bin/bash

# ** ADD GIT INFO **
#   Git info found in ./conf/git.conf
#   Add info using 'git config'

name=$(cat ../conf/git.conf | sed -rn -e 's/^name: (.+)$/\1/pg')
echo $name
git config --global user.name "$name"

email=$(cat ../conf/git.conf | sed -rn -e 's/^email: (.+)$/\1/pg')
echo $email
git config --global user.email $email

git config --global push.default simple
