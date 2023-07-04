#!/bin/dash

latest_commit () {

    max=0
    for folder in .pig/objects/*; do

        number=$(echo $folder | cut -d " " -f1 | cut -d "/" -f3) 
        if [ "$number" -gt "$max" ]; then
            max="$number"    

        fi
    done

    object_folder_name=$(ls ./.pig/objects/ | grep -e "$max\s")
    echo $object_folder_name
}


latest_commit