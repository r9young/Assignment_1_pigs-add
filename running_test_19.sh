#!/bin/dash

echo 1 >a
echo 2 >b
echo 3 >c
./pigs-add.sh a b c
./pigs-commit.sh -m "first commit"
# Committed as commit 0
echo 4 >>a
echo 5 >>b
echo 6 >>c
echo 7 >d
echo 8 >e
./pigs-add.sh b c d e
echo 9 >b
echo 0 >d
./pigs-rm.sh --cached a c
./pigs-rm.sh --force --cached b
./pigs-rm.sh --force --cached e
./pigs-rm.sh --force d
# ./pigs-status.sh
# a - deleted from index
# b - deleted from index
# c - deleted from index
# e - untracked