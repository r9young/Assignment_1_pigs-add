#!/bin/dash

init_file=".pig"

if [ -d "$init_file" ] ; then #checks if a directory named "pig" exists in the current directory. 
    echo "$0": error: "$init_file" already exists 
else
    mkdir "$init_file"
    mkdir "$init_file/HEAD.txt"
    mkdir "$init_file/branches"
    mkdir "$init_file/config"
    mkdir "$init_file/objects"
    mkdir "$init_file/refs"
    mkdir "$init_file/index"
    echo "Initialized empty pigs repository in .pig"
fi
