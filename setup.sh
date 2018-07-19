#!/bin/bash

# ** SETUP FILE **
#	This file generate the final script, based on all the modules available in Strawberry

# ** ARGUMENT CHECKER **
#   -h: User is asking for help
#		Help file is in ./help.conf
#   -f: Path & file name for final script
#       User must provide file path
#	If path isn't specified, generate file in project root

while getopts "hf:" OPTION; do
    case $OPTION in
        h )
            cat help.conf
            exit 0
            ;;
        f )
            if [[ -e $OPTARG ]]; then
                echo "File alredy exists: aborting"
                exit 1
            else
                echo "File does not exists: continuing"
                script=$OPTARG
            fi
            ;;
        ? )
            cat help.conf
            exit 1
            ;;
    esac
done

# If no argument was written, default file path is provided by the script
if [ $OPTIND -eq 1 ]; then
    script=$(date +"d%Ft%H-%M-%S-script").sh
    echo "File path was not provided. Generating file in $script"
fi

shift $((OPTIND-1))

# Creates the file & changes its permissions
touch $script
chmod u+x $script

# ** MODULE CALLING **
#   In this section of the script, we are checking each config file
#   If it's empty, user have not provided any information related to that specific module,
#   so this script does not call it. If the config file has some sort of info, then proceed to call it

# APT repositories module
./clean-file.sh conf/apt-repos.conf > /dev/null
if [ $? -eq 1 ]; then
    echo "APT repositories config file is empty"
else
    echo "Calling APT repositories module"
    ./modules/apt-repos.sh $script
fi

# APT package manager module
./clean-file.sh conf/apt.conf > /dev/null
if [ $? -eq 1 ]; then
    echo "APT packages file is empty"
else
    echo "Calling APT package manager module"
    ./modules/apt.sh $script
fi

# AUR package manager module
./clean-file.sh conf/aur.conf > /dev/null
if [ $? -eq 1 ]; then
    echo "AUR package manager config file is empty"
else
    echo "Calling AUR package manager module"
    ./modules/aur.sh $script
fi

# Edit files module
./clean-file.sh conf/edit.conf > /dev/null
if [ $? -eq 1 ]; then
    echo "Edit files config file is empty"
else
    echo "Calling edit files module"
    ./modules/edit.sh $script
fi

# Git account module
./clean-file.sh conf/git.conf > /dev/null
if [ $? -eq 1 ]; then
    echo "Git account config file is empty"
else
    echo "Calling Git account module"
    ./modules/git.sh $script
fi

# Links creation module
./clean-file.sh conf/links.conf > /dev/null
if [ $? -eq 1 ]; then
    echo "Links creation config file is empty"
else
    echo "Calling links creation module"
    ./modules/links.sh $script
fi

# Pacman package manager module
./clean-file.sh conf/pacman.conf > /dev/null
if [ $? -eq 1 ]; then
    echo "Pacman package manager config file is empty"
else
    echo "Calling Pacman package manager module"
    ./modules/pacman.sh $script
fi

# GitHub repositories cloning module
./clean-file.sh conf/repos.conf > /dev/null
if [ $? -eq 1 ]; then
    echo "GitHub cloning config file is empty"
else
    echo "Calling GitHub cloning module"
    ./modules/repos.sh $script
fi

# Default shell module
./clean-file.sh conf/shell.conf > /dev/null
if [ $? -eq 1 ]; then
    echo "Default shell config file is empty"
else
    echo "Calling default shell module"
    ./modules/shell.sh $script
fi

# SSH module
./clean-file.sh conf/ssh.conf > /dev/null
if [ $? -eq 1 ]; then
    echo "SSH config file is empty"
else
    echo "Calling SSH module"
    ./modules/ssh.sh $script
fi
