#!/bin/dash
echo 1 >a
echo 2 >b
echo 3 >c
./pigs-add.sh a b c
./pigs-commit.sh -m "first commit"
echo 4 >>a
echo 5 >>b
echo 6 >>c
echo 7 >d
echo 8 >e
./pigs-add.sh b c d
echo 9 >b
./pigs-rm.sh a
# pigs-rm.sh: error: 'a' in the repository is different to the working file # w 1 4 i 1 c 
./pigs-rm.sh b
# pigs-rm.sh: error: 'b' in index is different to both the working file and the repository
./pigs-rm.sh c
# pigs-rm.sh: error: 'c' has staged changes in the index
./pigs-rm.sh d
# pigs-rm.sh: error: 'd' has staged changes in the index
./pigs-rm.sh e
# pigs-rm.sh: error: 'e' is not in the pigs repository
./pigs-rm.sh --cached a
./pigs-rm.sh --cached b
# pigs-rm.sh: error: 'b' in index is different to both the working file and the repository
./pigs-rm.sh --cached c
./pigs-rm.sh --cached d
# ./pigs-rm.sh --cached e
# pigs-rm.sh: error: 'e' is not in the pigs repository
# ./pigs-rm.sh --force a
# # pigs-rm.sh: error: 'a' is not in the pigs repository
# ./pigs-rm.sh --force b
# ./pigs-rm.sh --force c
# # pigs-rm.sh: error: 'c' is not in the pigs repository
# ./pigs-rm.sh --force d
# # pigs-rm.sh: error: 'd' is not in the pigs repository
# ./pigs-rm.sh --force e
# # pigs-rm.sh: error: 'e' is not in the pigs repository