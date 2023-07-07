echo hi >a
./pigs-add.sh a
./pigs-commit.sh -m message
# Committed as commit 0
echo hello >b
echo hola >c
./pigs-add.sh b c
# ./pigs-status
# a - same as repo
# b - added to index
# c - added to index
echo there >>b
rm c
./pigs-status
# a - same as repo
# b - added to index, file changed
# c - added to index, file deleted