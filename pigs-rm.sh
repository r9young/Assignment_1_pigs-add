#!/bin/dash



num_arg=$#
stage_dir=".pig/index"
comit_dir=".pig/objects"
working_dir="."


latest_commit () {

    max=0
    max_folder=""
    for folder in .pig/objects/*; do

        number=$(echo $folder | cut -d " " -f1 | cut -d "/" -f3) 
        if [ "$number" -gt "$max" ]; then
            max="$number"
            max_folder="$folder"
        fi
    done

    echo $max_folder

}



if [ "$1" = "--cached" ]; then 
    for arg_cached in "$@"; do 
        if [ "$arg_cached" = "--cached" ]; then
            continue
        elif [ ! -f $stage_dir/$arg_cached ]; then
            echo pigs-show: error: $arg_cached not found in index
        elif [ -f $stage_dir/$arg_cached ]; then
            rm $stage_dir/$arg_cached
        fi
    done

elif [ ! "$1" = "--cached" ] || [ ! "$1" = "--force" ]; then
    for arg_rm in "$@"; do 
        if [ ! -f $stage_dir/$arg_rm ]; then
            echo "$0: error: '$arg_rm' is not in the pigs repository"

        elif [ -f $stage_dir/$arg_rm ]; then

            object_folder=$(latest_commit)
            folder=$(echo $object_folder | cut -d"/" -f3)
            filename=$(echo $folder | tr " " "/n" |tr "/" " ") # we need to fix this problem: in "3 second commit", there must be some whitespace


            if [ -f $arg_rm ] && [ ! -d ".pig/objects/$foldername/$arg_rm" ]; then
                echo "pigs-rm: error: '$arg_rm' has staged changes in the index"
            fi
        
        #     if [ -f $arg_rm ] && [ ! -f $comit_dir/$(latest_commit)/$arg_rm ]; then
        #         echo "pigs-rm: error: '$arg_rm' has staged changes in the index"
        #     elif [ -f $arg_rm ] && [ -f $comit_dir/$(latest_commit)/$arg_rm ]; then
        #         echo "yes"


            # fi
        fi 
    done  
fi









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

