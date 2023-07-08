#!/bin/dash

./pigs-init.sh
echo hello >a
./pigs-add.sh a
./pigs-commit.sh -m first commit
./pigs-commit.sh -m second commit