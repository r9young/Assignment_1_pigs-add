#!/bin/dash


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

object_folder=$(latest_commit)
folder=$(echo $object_folder | cut -d"/" -f3)
foldername=$(echo $folder | tr " " "/n" |tr "/" " ")
# echo $foldername

index_path=".pig/index"
commit_path=.pig/objects/"$foldername"

#-------------------search all the files in the current directory
file_list=""

for file_index in $index_path/*; do
    if [ -f "$file_index" ]; then
        index_file=$(basename "$file_index")
        file_list="$file_list $index_file"
    
    fi
done

for file_commit in .pig/objects/"$foldername"/*; do
    if [ -f "$file_commit" ]; then
        commit_file=$(basename "$file_commit")
        file_list="$file_list $commit_file"
    fi
    # echo $file_commit
done


for file in * ; do
    if [ -f "$file" ]; then
        # Get the base file name
        file_name=$(basename "$file")
        case "$file_name" in
            *.* ) ;; # Skip files with extension
            * ) 
                file_list="$file_list $file_name" 
            ;;
        esac
    fi
done

allfile=$(echo "$file_list"  | tr ' ' '\n' | sort -u)

# echo $allfile


#-------------------

for file in $allfile; do
    if [ ! -e "$index_path/$file" ] && [ -e "$commit_path/$file" ] && [ -e "$file" ]; then
        echo "$file - deleted from index" #19 a b c
        
    elif [ ! -e "$index_path/$file" ] && [ ! -e "$commit_path/$file" ]; then
        echo "$file - untracked"

    elif [ ! -e "$index_path/$file" ] && [ -e "$commit_path/$file" ] && [ ! -e "$file" ];then
        echo "$file - file deleted, deleted from index"

    elif [ -e "$index_path/$file" ] && [ -e "$commit_path/$file" ] && [ ! -e "$file" ];then
        echo "$file - file deleted"

     elif [ -e "$index_path/$file" ] && [ ! -e "$commit_path/$file" ] && [ ! -e "$file" ];then
        echo "$file - added to index, file deleted"

    elif [ -e "$index_path/$file" ] && [ ! -e "$commit_path/$file" ] && [ -e "$file" ];then
        if diff -iBw "$file" "$index_path/$file" >/dev/null 2>&1; then
            echo "$file - added to index" #20 g
        elif ! diff -iBw "$file" "$index_path/$file" >/dev/null 2>&1; then
            echo "$file - added to index, file changed" #21 h
        fi
        
    elif [ -e "$index_path/$file" ] && [ -e "$commit_path/$file" ] && [ -e "$file" ]; then
        if  
            ! diff -iBw "$file" "$index_path/$file" >/dev/null 2>&1 &&
            ! diff -iBw "$commit_path/$file" "$index_path/$file" >/dev/null 2>&1 &&
            ! diff -iBw "$commit_path/$file" "$file" >/dev/null 2>&1; then
                    echo "$file - file changed, different changes staged for commit"
        elif 
            ! diff -iBw "$commit_path/$file" "$index_path/$file" >/dev/null 2>&1 &&
            ! diff -iBw "$file" "$commit_path/$file" >/dev/null 2>&1 &&
              diff -iBw "$file" "$index_path/$file" >/dev/null 2>&1; then
                    echo "$file - file changed, changes staged for commit"
        elif
               diff -iBw "$commit_path/$file" "$index_path/$file" >/dev/null 2>&1 &&
            !  diff -iBw "$file" "$commit_path/$file" >/dev/null 2>&1 &&
            !  diff -iBw "$file" "$index_path/$file" >/dev/null 2>&1; then
                    echo "$file - file changed, changes not staged for commit"

        elif
               diff -iBw "$commit_path/$file" "$index_path/$file" >/dev/null 2>&1 &&
            !  diff -iBw "$file" "$commit_path/$file" >/dev/null 2>&1 &&
            !  diff -iBw "$file" "$index_path/$file" >/dev/null 2>&1; then
                    echo "$file - file changed, changes not staged for commit"

        elif
               diff -iBw "$commit_path/$file" "$index_path/$file" >/dev/null 2>&1 &&
               diff -iBw "$file" "$commit_path/$file" >/dev/null 2>&1 &&
               diff -iBw "$file" "$index_path/$file" >/dev/null 2>&1; then
                    echo "$file - same as repo"
            
        fi 
    fi
done












# As noted by Joshua in #746 

# the Reference Implementation was showing "untracked" when it probably shouldn't have been.

# After a quick investigation into what git was doing we (I) have decided to update the output from pigs-stastus in three situations.

# firstly:
# the deleted status has been updated to file deleted, deleted from index

# secondly:
# in some (but not all) situations untracked has been updated to deleted from index 

# thirdly:
# another case not covered in the provided tests has been modified slightly.


# The first and second case are tested by autotest so previously correct code will now fail 3 autotests. 

# the autotest output and playing with the Reference Implementation should provide enough information to update your previously correct code fairly easily.

# The third case is something for you to find in the Reference Implementation (and maybe write a test for it so that you can catch future changes)


# https://edstem.org/au/courses/12028/discussion/1456791