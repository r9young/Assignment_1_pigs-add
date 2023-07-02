#!/bin/dash

input=$1

file_name=$(echo $input | cut -d ":" -f2 )
fold_serial=$(echo $input | cut -d ":" -f1)




index_path=".pig/index/"
object_path=".pig/objects/"

if [ -z $fold_serial ]; then
    if [ ! -f "$index_path/$file_name" ]; then
    
        echo "$0: error: '$file_name' not found in index"
    fi

elif [ -n "$fold_serial" ]; then
    if [ ! -f "$object_path/.snapshot.0/$file_name" ]; then
        echo "$0: error: '$file_name' not found in commit 0"
    fi
else

    file_path=".pig/objects/.snapshot.$fold_serial/$file_serial"
    while read -r line 
    do
        echo "$line"
    done  < $file_path 

fi

