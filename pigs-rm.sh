#!/bin/dash



num_arg=$#
stage_dir=".pig/index"
comit_dir=".pig/objects"
working_dir="."

latest_commit () {

    max=-1
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

        object_folder=$(latest_commit)
        folder=$(echo $object_folder | cut -d"/" -f3)
        foldername=$(echo $folder | tr " " "/n" |tr "/" " ") # we need to fix this problem: in "3 second commit", there must be some whitespace
        

        if [ "$arg_cached" = "--cached" ]; then
            continue

        elif [ ! -e $stage_dir/$arg_cached ] ; then

            if  ! diff -iBw ".pig/objects/$foldername/$arg_cached" "$arg_cached" >/dev/null 2>&1; then
                echo "$0: error: '$arg_cached' is not in the pigs repository"
            else
                echo pigs-show: error: $arg_cached not found in index
            fi

        elif [ -e $stage_dir/$arg_cached ]; then

            if  ! diff -iBw "$stage_dir/$arg_cached" "$arg_cached" >/dev/null 2>&1 &&
                ! diff -iBw "$stage_dir/$arg_cached" ".pig/objects/$foldername/$arg_cached" >/dev/null 2>&1; then
                    echo "$0: error: '$arg_cached' in index is different to both the working file and the repository"

            elif diff -iBw "$stage_dir/$arg_cached" ".pig/objects/$foldername/$arg_cached" >/dev/null 2>&1; then
                rm $stage_dir/$arg_cached
        
            else
                rm $stage_dir/$arg_cached
            fi
        fi
    done

#----------------------------------------------------------#

elif [ "$1" = "--force" ] && [ "$2" = "--cached" ]; then 

        for arg_fc in "$@"; do 

            object_folder=$(latest_commit)
            folder=$(echo $object_folder | cut -d"/" -f3)
            foldername=$(echo $folder | tr " " "/n" |tr "/" " ") # we need to fix this problem: in "3 second commit", there must be some whitespace
            

            if [ "$arg_fc" = "--force" ]; then
                continue

            elif [ "$arg_fc" = "--cached" ]; then
                continue

            elif [ -e .pig/index/$arg_fc ]  >/dev/null 2>&1; then
                rm .pig/index/$arg_fc
            fi
        done


#----------------------------------------------------------#

elif [ "$1" = "--force" ]; then 
    object_folder=$(latest_commit)
    folder=$(echo $object_folder | cut -d"/" -f3)
    foldername=$(echo $folder | tr " " "/n" |tr "/" " ") # we need to fix this problem: in "3 second commit", there must be some whitespace
        
    for arg_force in "$@"; do 
        if [ "$arg_force" = "--force" ]; then
            continue
        
        elif [  -e "$arg_force" ] && [  -e ".pig/index/$arg_force" ] >/dev/null 2>&1; then
            rm "$arg_force">/dev/null 2>&1
            rm "$stage_dir/$arg_force">/dev/null 2>&1
            
        elif [ -e "$arg_force" ] && [ ! -e ".pig/index/$arg_force" ] >/dev/null 2>&1; then
            echo "$0: error: '$arg_force' is not in the pigs repository"
        fi
        
    done


# If a file is not in the last commit, it means it's not yet part of the Git repository (unless it's part of the staging area but not yet committed). 
#----------------------------------------------------------#
  

elif [ ! "$1" = "--cached" ] || [ ! "$1" = "--force" ]; then
    for arg_rm in "$@"; do 
        if [ ! -e $stage_dir/$arg_rm ] >/dev/null; then
            echo "$0: error: '$arg_rm' is not in the pigs repository"

        elif [ -e $stage_dir/$arg_rm ]; then
        
            object_folder=$(latest_commit)
            folder=$(echo $object_folder | cut -d"/" -f3)
            foldername=$(echo $folder | tr " " "/n" |tr "/" " ") # we need to fix this problem: in "3 second commit", there must be some whitespace
            
  
            if [ ! -e ".pig/objects/$foldername/$arg_rm" ]; then
                echo testing_index > .pig/objects/$foldername/$arg_rm
            fi

 
            if ! diff -iBw "$stage_dir/$arg_rm" ".pig/objects/$foldername/$arg_rm" 2>&1 >/dev/null &&
                diff -iBw "$stage_dir/$arg_rm" "$arg_rm" 2>&1 >/dev/null; then
                    echo "pigs-rm: error: '$arg_rm' has staged changes in the index"
                    rm .pig/objects/$foldername/$arg_rm 2>/dev/null
                   

            
            elif ! diff -iBw "$stage_dir/$arg_rm" "$arg_rm" 2>&1 >/dev/null &&
                diff -iBw "$stage_dir/$arg_rm" ".pig/objects/$foldername/$arg_rm" 2>&1 >/dev/null; then
                    echo "$0: error: '$arg_rm' in the repository is different to the working file"
                    rm .pig/objects/$foldername/$arg_rm 2>/dev/null
                    

            elif ! diff -iBw "$stage_dir/$arg_rm" "$arg_rm" 2>&1 >/dev/null &&
                 ! diff -iBw "$stage_dir/$arg_rm" ".pig/objects/$foldername/$arg_rm" 2>&1 >/dev/null; then
                    echo "$0: error: '$arg_rm' in index is different to both the working file and the repository"
                    rm .pig/objects/$foldername/$arg_rm 2>/dev/null
                  
                
            else
                rm "$arg_rm"
                rm "$stage_dir/$arg_rm"
                rm .pig/objects/$foldername/z.txt 2>/dev/null
            fi
            
        fi 
    done  
fi


