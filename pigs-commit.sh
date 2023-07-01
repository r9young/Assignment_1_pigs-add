#!/bin/bash

file_add=$1


max=0
if ls .pig/objects/.snapshot.* >/dev/null 2>&1; then
    for snap_dir in .pig/objects/.snapshot.*; do
        number=$(echo $snap_dir | cut -d "." -f4 )
        if [ "$number" -gt "$max" ]; then
            max="$number"
        fi
    done

elif ! ls .pig/objects/.snapshot.* >/dev/null 2>&1; then
    max=-1
fi

max=$(($max+1))
mkdir .pig/objects/.snapshot."$max"

for backup_file in .pig/index/*; do
    cp $backup_file .pig/objects/.snapshot.$max/
done

echo Creating snapshot "$max"


