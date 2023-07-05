#!/bin/dash

option_1="--catched"

for arg in "$@"; do 
    if [ -d $option_1 ]; then
        echo $option_1
        # for file in $@; do
        #     if [ ! "$file" = "--catched" ]; then
        #         if [ ! -f $stage_dir/$file ]; then
        #             echo pigs-show: error: $file not found in index
        #         elif [ -f $stage_dir/$file ]; then
        #             rm $stage_dir/$file
        #         fi
        #     fi
        # done
    fi
done

