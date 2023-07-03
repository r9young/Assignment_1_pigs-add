#!/bin/dash

num_arg=$#

if [ $num_arg -eq 3 ]; then 
    files_index=$(ls ./.pig/index/)
    files_working=$(ls .)
    for indexfile in $files_index;do
      for workingfile in $files_working;do
        if [ "$indexfile" = "$workingfile" ]; then
          echo $workingfile
          cp $workingfile ./.pig/index/
        fi
      done
    done
   
fi



