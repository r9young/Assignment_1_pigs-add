#!/bin/dash

commit() {
    
    file_name="$*"
    search_path=".pig/objects"

    max=0
    backup_files_exist=$(ls -A "$search_path")
    if [ -z "$backup_files_exist" ]; then
        mkdir .pig/objects/"$max $file_name"
        echo Committed as commit "$max"
        
        for backup_file in .pig/index/* ; do
                cp "$backup_file" .pig/objects/"$max $file_name" 
        done
        

    elif [ -n "$backup_files_exist" ]; then
            for backup_fold in "$search_path"/*; do
                number=$(echo "$backup_fold" | cut -d " " -f1 | cut -d "/" -f3) 
                if [ "$number" -gt "$max" ]; then
                    max="$number"  
                fi
            done

            object_folder_name=$(ls ./.pig/objects/ | grep -E "$max") #substitue it
                 
            # for file1 in ".pig/index/"; do --- wrong
            #     for file2 in ".pig/objects/$object_folder_name"; do --- wrong
            file1=".pig/index/"
            file2=".pig/objects/$object_folder_name"
            if diff -iBw "$file1" "$file2" >/dev/null 2>&1; then # if the files are exactly same
                echo "nothing to commit" 
            else
                serial_number=$((max+1))
                mkdir .pig/objects/"$serial_number $file_name"
                for backup_file in .pig/index/* ; do 
                    cp "$backup_file" .pig/objects/"$serial_number $file_name"/ 2>/dev/null
                done
                echo Committed as commit "$serial_number"
            fi
            #     done
            # done
    fi
}


add() {
    files_index=$(ls ./.pig/index/)
    files_working=$(ls .)
    for indexfile in $files_index;do
      for workingfile in $files_working;do
        if [ "$indexfile" = "$workingfile" ]; then
          cp "$workingfile" ./.pig/index/
        fi
      done
    done
}


num_arg=$#


if [ $num_arg -eq 2 ]; then 
    commit "$2"

elif [ $num_arg -eq 3 ]; then 
    add
    commit "$3"

fi



