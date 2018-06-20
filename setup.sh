#!/bin/bash

# **ARGUMENT CHECKER**
#   -h: User is asking for help
#   -f: Path & file name for generated script
#TODO

# **ADD GIT INFO**
#   IN git.conf
#   Add info to 'git config'
#TODO

# **GITHUB REPO CLONING**
#   In repos.conf
#   Clone specified GitHub repos
#TODO

# **UPLOAD SSH KEY TO GITHUB**
#   In ssh.conf
#   Get ssh info & GitHub username
#TODO

# **DOWNLOAD PACKAGES**
#   Check user distro
#   Get the name of the 'parent distro'
#   For example, ID_LIKE from Ubuntu is Debian
distro=$(cat /etc/*-release | grep ID_LIKE | sed -rne 's/^.*"(.*)"$/\1/p')

#   Check if $distro's package manager is compatible with strawberry
if [[ $distro == arch ]] || [[ $distro == debian ]] || [[ $distro == fedora ]]; then
    echo "Distro is recognized as $distro"
else
    echo "Distro not recognized :("
fi

#   Check if specific package manager file is empty

# **CHANGE DEFAULT SHELL**
#   In shell.conf
#   Check shell path
#   cat /etc/shells for available shells
#TODO

# **GENERATE LINKS**
#   In links.conf
#   Generate link from a specific file
#   Check if hard or soft
#TODO

# **EDIT FILES**
#   In edit.conf
#   Get file to edit & what to edit
#TODO
