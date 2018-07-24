#!/bin/bash

# ** SETUP FILE **
#	This file generate the final script, based on all the modules available in Strawberry
#   First it checks command arguments, and generates the script path file
#   And then calls every module one by one, writting their output in the final script
#   All modules are found in ./modules folder
#   Config files are found in ./conf folder
#   Check the color.conf file, for color information

# Prints the main title
printf "\033[1;91m"
cat title.conf

# ** ARGUMENT CHECKER **
#   -h: User is asking for help
#		Help file is in ./help.conf
#   -f: Path & file name for final script
#       User must provide file path
#	If path isn't specified, generate file in project root

while getopts "hf:" OPTION; do
    case $OPTION in
        h )
            printf "\033[1;37m"
            cat help.conf
            exit 0
            ;;
        f )
            # If the file aldery exists, abort
            if [[ -e $OPTARG ]]; then
                printf "\033[1;91m" # Prints it in red
                echo "The file alredy exists!"
                echo "Please, input another file. Aborting..."
                echo
                printf "\033[1;37m"
                cat help.conf
                exit 1
            else
                printf "\033[1;96m" # Prints it in cyan
                echo "Path file does not exisits. Continuing..."
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
# Default file name: d[YYYY]-[MM]-[DD]t[HH]-[mm]-[SS].sh
if [ $OPTIND -eq 1 ]; then
    script=$(date +"d%Ft%H-%M-%S").sh
    printf "\033[1;96m" # Prints it in cyan
    echo "File path was not provided. Default name applied."
fi 
echo "Generating file '$script'..."

shift $((OPTIND-1))

# Creates the file & changes its permissions
touch $script
chmod u+x $script
echo "# SCRIPT GENERATED WITH PROJECT: STRAWBERRY" > $script
echo "# PROJECT: STRAWBERRY IS A FREE & OPEN PROJECT" >> $script
echo "# VISIT THE PROJECT AT https://github.com/jesusrp98" >> $script

# ** MODULE CALLING **
#   In this section of the script, we are checking each config file
#   If it's empty, user have not provided any information related to that specific module,
#   so this script does not call it. If the config file has some sort of info, then proceed to call it

echo -e "\nModule config file are found in ./conf folder."
echo "Modules source code are found in ./modules folder."

echo -e "\nCalling modules..."

# Array that contains all module name
# It is easier to call them with a for loop :)
declare -a modules=(git ssh repos apt-repos apt pacman aur shell links edit enviroment)

# Calls every module via a loop
for module in "${modules[@]}"; do
    # Cleans config file and then check content
    ./clean-file.sh conf/$module.conf > /dev/null
    if [ $? -eq 1 ]; then
        printf "\033[1;91m" # Prints it in red
        echo " Config file from '$module' module is empty!"
    else
        printf "\033[1;92m" # Prints it in green
        echo " Calling '$module' module..."
        ./modules/$module.sh $script
    fi
done

# Prints final information
printf "\033[1;96m"
echo -e "\nFile generated in: '$(realpath $script)'."
echo -e "You can now edit the final script as you want.\n"
echo "Please, consider sharing the project with your UNIX-nerd friends."
echo "This is a free & open project: edit it as you wish :)"
echo "https://github.com/jesusrp98/strawberry"
echo -e "Thanks for using Project: Strawberry!\n"
