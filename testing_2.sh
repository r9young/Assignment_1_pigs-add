#!/bin/dash
num_arg=$#


if [ $num_arg -eq 2 ]; then 
  
    if [ "$1" = "--catched" ]; then
        echo $1 
    fi
fi
