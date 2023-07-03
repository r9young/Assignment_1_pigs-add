#!/bin/dash


# input=$1



# folder_serial=$(echo $input | cut -d ":" -f1)

# get_folder_name() {
#     folder_name=$(ls ./.pig/objects/ | grep -E "$folder_serial")
#     echo $folder_name
# }
# folder_name=$(get_folder_name)

# file_name=$(echo $input | cut -d ":" -f2 )

# index_path=".pig/index"
# object_path=".pig/objects"


# file_path="./.pig/objects/$folder_name/$file_name"

file_name="a"
folder_name="1 second commit"

file_path=".pig/objects/$folder_name/$file_name"
echo $file_path


if [ -f "$file_path" ]; then 
  echo "yes"
else
  echo "no"
fi