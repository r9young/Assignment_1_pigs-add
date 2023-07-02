#!/bin/dash


search_path=".pig/objects"

ls $search_path | sort -t '/' -k3 -r
