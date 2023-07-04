#!/bin/dash

input=$1

info="$(echo $input)"

folder_serial=$(echo $info | cut -d ":" -f1)
folder_name=$(ls ./.pig/objects/ | grep -E "$folder_serial")


file_name=$(echo $info | cut -d ":" -f2)

index_path=".pig/index"
object_path=".pig/objects"

file_path=".pig/objects/$folder_name/$file_name"

#check index
if [ -z  $folder_serial ]; then # This checks if the variable $folder_serial is empty or not set. e.g pig show :a
    if [ ! -f "./.pig/index/$file_name" ]; then #This checks if a file does not exist. 
        echo "$0: error: '$file_name' not found in index"
    else
        index_file_path="./.pig/index/$file_name"
        while read -r line 
        do
            echo "$line"
        done  < "$index_file_path"
    fi

#check objects
else
    if [ -z "$folder_name" ]; then # the problem of previous code is we forget that $folder_name loop the folder, so we don't need loop again
        echo "$0: error: unknown commit '$folder_serial'"
   
    elif [ ! -f "./.pig/objects/$folder_name/$file_name" ]; then 
        echo "$0: error: '$file_name' not found in commit $folder_serial"

    else
        object_file_path="./.pig/objects/$folder_name/$file_name"
        while read -r line 
        do
            echo "$line"
        done  < "$object_file_path"
        
    fi
fi




# $ echo line 3 >> a
# $ pigs-add a
# $ echo line 4 >> a
# $ pigs-show 0:a
# line 1
# $ pigs-show 1:a
# line 1
# line 2
# $ pigs-show :a
# line 1
# line 2
# line 3