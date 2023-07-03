#!/bin/dash

for file1 in ".pig/index/"
do
    for file2 in ".pig/objects/9 sixth commit/"
    do
        if diff -iBw "$file1" "$file2" >/dev/null
        then
            echo "$file1 is a copy of $file2"
        else
            echo "it is different"

        fi
    done
done

