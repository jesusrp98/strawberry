#!/bin/bash

# ** SETUP FILE **
#	This file generate the final script, based on all the modules available in Strawberry

# ** ARGUMENT CHECKER **
#   -h: User is asking for help
#		Help file is in ./help.conf
#   -f: Path & file name for final script
#		If path isn't specified, generate file in project root

touch $1
./modules/repos.sh $1 
