#!/bin/dash

option=$1
file_name=$2
search_path=".pig/objects"

max=0
backup_files_exist=$(ls -A $search_path)
if [ -z "$backup_files_exist" ]; then
    mkdir .pig/objects/"$max $file_name"
    echo Committed as commit "$max"
    
    for backup_file in .pig/index/*; do
            cp $backup_file .pig/objects/"$max $file_name"
    done
    

elif [ -n "$backup_files_exist" ]; then
        for backup_fold in $search_path/*; do
            number=$(echo $backup_fold | cut -d " " -f1 | cut -d "/" -f3) 
            if [ "$number" -gt "$max" ]; then
                max="$number"  
            fi
        done
        serial_number=$(($max+1))
        mkdir .pig/objects/"$serial_number $file_name"
        for backup_file in .pig/index/*; do
            cp $backup_file .pig/objects/"$serial_number $file_name"/
        done
        echo Committed as commit "$serial_number"

fi









