#!/bin/dash

#15
# echo 1 >a
# echo 2 >b
# ./pigs-add.sh a b
# ./pigs-commit.sh -m "first commit"
# echo 3 >c
# echo 4 >d
# ./pigs-add.sh c d
# ./pigs-rm.sh --cached  a c
# ./pigs-commit.sh -m "second commit"
# ./pigs-show.sh 0:a
# ./pigs-show.sh 1:a
# ./pigs-show.sh :a



touch a b
./pigs-add.sh a b
./pigs-commit.sh -m "first commit"
rm a
./pigs-commit.sh -m "second commit"
./pigs-add.sh a