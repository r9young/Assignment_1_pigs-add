#!/bin/dash

./pigs-init.sh
touch a b
./pigs-add.sh a b
./pigs-commit.sh -m "first commit"
rm a
./pigs-commit.sh -m "second commit"
./pigs-add.sh a
./pigs-commit.sh -m "second commit"
./pigs-rm.sh --cached b
./pigs-commit.sh -m "second commit"
./pigs-rm.sh b
./pigs-add.sh b
./pigs-rm.sh b
./pigs-commit.sh -m "third commit"
./pigs-rm.sh b
# ./pigs-commit.sh -m "fourth commit"
