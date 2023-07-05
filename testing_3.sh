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

object_folder=$(latest_commit)
folder=$(echo $object_folder | cut -d"/" -f3)
filename=$(echo $folder | tr " " "/n" |tr "/" " ") # we need to fix this problem: in "3 second commit", there must be some whitespace



if [ -d ".pig/objects/$filename" ]; then
    echo "yes"
fi

