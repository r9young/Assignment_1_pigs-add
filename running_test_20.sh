#!/bin/dash

touch a b c d e f g h
./pigs-add.sh a b c d e f
./pigs-commit.sh -m "first commit"
# Committed as commit 0
echo hello >a
echo hello >b
echo hello >c
./pigs-add.sh a b
echo world >a
rm d
./pigs-rm.sh e
./pigs-add.sh g
./pigs-status
# a - file changed, different changes staged for commit
# b - file changed, changes staged for commit
# c - file changed, changes not staged for commit
# d - file deleted
# e - file deleted, deleted from index
# f - same as repo
# g - added to index
# h - untracked