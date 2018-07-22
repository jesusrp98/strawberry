#!/bin/bash

# ** CHANGE DEFAULT SHELL* *
#   New default shell found in ./conf/shell.conf
#   'cat /etc/shells' for available shells
# 	Change shell via 'chsh' command

#Asigno a una variable la(s) shells
newShell=$(. ./clean-file.sh ./conf/shell.conf)

#Miro si solo hay una
if [ $(echo "$newShell" | wc -l) != 1 ];then
	echo "ERROR: Solo puede haber una shell en el shell.conf!"
	exit 0
fi

#Compruebo que exista dicha shell
found=0
for x in $newShell
do
	if [ $x == $newShell ];then
		found=1
	fi
done

if [ "$found" != 1 ];then
	echo "ERROR: No existe la shell especificada!"
	exit 0
fi

echo -e "\n# Changing default shell" >> $1

#Imprimo en el lugar especificado por paramtros el comando de chsh con el shell a usar
echo "chsh -s "$newShell"" >> $1
