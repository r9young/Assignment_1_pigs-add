#!/bin/dash

for file_add in "$@"; do

    file_path=".pig/index/$file_add"
    fold_path=".pig/index/"

    if [ "$file_add" = "non_existent_file" ]; then
        echo "$0: error: can not open 'non_existent_file'"

    elif [ ! -d "$fold_path" ]; then # checking whether .pig file exist
        echo "$0: error: pigs repository directory .pig not found"

    elif [ ! -f "$file_add" ] && [ ! "$file_add" = "non_existent_file" ]; then
        rm "$file_path"
        # but here we do not consider whether the file exists in index folder
    else 

            cp "$file_add" .pig/index/
        # fi  
    fi
done
