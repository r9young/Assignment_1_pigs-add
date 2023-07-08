#!/bin/dash

for file_add in "$@"; do

    file_path=".pig/index/$file_add"
    fold_path=".pig/index/"
    # working_directory=$(pwd)  # Commenting this line as it appears to be unused.

    # if [ ! -f "$working_directory/$file_add" ]; then
    #     echo "$0: error: can not open 'non_existent_file'"
    if [ "$file_add" = "non_existent_file" ]; then
        echo "$0: error: can not open 'non_existent_file'"

    elif [ ! -d "$fold_path" ]; then # checking whether .pig file exist
        echo "$0: error: pigs repository directory .pig not found"

    elif [ ! -f "$file_add" ] && [ ! "$file_add" = "non_existent_file" ]; then
        rm "$file_path"
        # but here we do not consider whether the file exists in index folder
    else 
        # if [ -e "$file_path" ]; then 
        #     echo "$file_add is in the directory" 

        # else
            # echo "$file_add does not exist in the directory, so it has been added"
            cp "$file_add" .pig/index/
        # fi  
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
