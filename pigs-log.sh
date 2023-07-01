#!/bin/sh

for file in .pig/objects/.snapshot.*; do
    basename "$file"
done 2>/dev/null
