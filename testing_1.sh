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
echo $foldername

index_path=".pig/index"
commit_path=.pig/objects/"$foldername"

#-------------------search all the files in the current directory
file_list=""

for file_index in $index_path/*; do
    if [ -f "$file_index" ]; then
        index_file=$(basename "$file_index")
        file_list="$file_list $index_file"
        echo $index_file
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
                # echo $file_name
            ;;
        esac
    fi
done

allfile=$(echo "$file_list"  | tr ' ' '\n' | sort -u)

# echo $allfile