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
    # Asking for help
        h )
            cat help.conf
            exit 0
            ;;
    # Input a file path
    # User must provide file path
        f )
            if [[ -e $OPTARG ]]; then
                echo "existe"
                exit 1
            else
                echo "no exite"
                script=$OPTARG
            fi
            ;;
        ? )
            cat help.conf
            exit 1
            ;;
    esac
done

# If no argument was written
# Default file path
if [ $OPTIND -eq 1 ]; then
    script=$(date +"d%Ft%H-%M-%S-script").sh
    echo "File path was not provided. Generating file in $script"
fi

shift $((OPTIND-1))

# Creates the file
touch $script
