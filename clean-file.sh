#!/bin/bash

# ** CLEAN FILE **

#	Receive a .conf file from the ./conf folder.
#	It cleans all comments (#) & all the blank lines
#   Returns the cleaned file
#   USE IT TO PROCESS .CONF FILES!

cat $1 | grep -E '[^$]' | grep -vE '^[ ]*#'
