#!/bin/bash

# ** CHANGE DEFAULT SHELL* *
#   New default shell found in ./conf/shell.conf
#   'cat /etc/shells' for available shells
# 	Change shell via 'chsh' command

#Comprueba argumentos
if [ $# != 1 ];then
	echo "ERROR: No has introducido el archivo resultado!"
	exit 0
fi

#Asigno a una variable la(s) shells
newShell=$(../clean-file.sh "../conf/shell.conf")

#Miro si solo hay una
if [ $( (../clean-file.sh "../conf/shell.conf") | wc -l) != 1 ];then
	echo "ERROR: Solo puede haber una shell en el shell.conf!"
	exit 0
fi

#Compruebo que exista dicha shell
found=0
for x in $(../clean-file.sh "/etc/shells")
do
	if [ $x == $newShell ];then
		found=1
	fi
done

if [ "$found" != 1 ];then
	echo "ERROR: No existe la shell especificada!"
	exit 0
fi

#Imprimo en el lugar especificado por paramtros el comando de chsh con el shell a usar
echo "chsh -s "$newShell"" > "$1"
