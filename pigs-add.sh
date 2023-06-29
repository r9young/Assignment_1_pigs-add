#!/bin/bash

file_add=$1

for file_in_working in *; do # for loop all the files in working directory
    if [ "$file_add" = "$file_in_working" ]; then #check if adding file is in current working directory
        echo "$file_add is matched" 
        break
    else
        echo "file does not exist"
        break
    fi
done


# step: 1
# for loop all the files in working directory

#step: 2
# testing whether the file want to be add to staging area is in working directory
# if the file has already been add in working directory, 
# for loop all the file in staging area
# othwise echo "files does not exit in working directory"

# step 3: 
# for loop all the file in staging area
# if the file_add's name is same as teh file name in staging area. then you do diff
# diff two file - updating the changes as per diff's result 
# otherwise, adding the file in staging area
