#!/bin/dash


filename=$1
num_arg=$#
stage_dir=".pig/index"
comit_dir=".pig/objects"
working_dir="."


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

if [ $num_arg -eq 1 ]; then     
    if [ ! -f $stage_dir/$filename ]; then
        echo "$0: error: "$filename" is not in the pigs repository"
     

    fi
fi
        
# elif [ $num_arg -eq 2 ]; then 
    
#     option=$1
#     filename=$2

# fi

