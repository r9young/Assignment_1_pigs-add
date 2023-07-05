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


for arg in "$@"; do 
    if [ "$arg" = "--cached" ]; then
        for file in $@; do
            if [ ! "$file" = "--cached" ]; then
                rm $stage_dir/$file
                # if [ ! -f $stage_dir/$file ]; then
                #     echo pigs-show: error: $file not found in index
                # elif [ -f $stage_dir/$file ]; then
                #     rm $stage_dir/$file
                # fi
            fi
        done
    fi
done





# if [ $num_arg -eq 1 ]; then     
#     if [ ! -f $stage_dir/$filename ]; then
#         echo "$0: error: "$filename" is not in the pigs repository"
#     fi
      
# elif [ $num_arg -ge 2 ]; then 
#     if [ "$1" = "--catched" ]; then
#         for arg in $@; do
#             # if [ "$arg" = "--catched" ]; then
#             #     continue
#             if [ ! "$arg" = "--catched" ]; then
#                 if [ ! -f $stage_dir/$arg ]; then
#                     echo pigs-show: error: $arg not found in index
#                 elif [ -f $stage_dir/$arg ]; then
#                     rm $stage_dir/$arg
#                 fi
#             fi
#         done
#     fi
# fi

