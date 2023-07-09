#!/bin/dash
# init add commit status


rm -r ./.pig  >/dev/null 2>&1
rm a b c d e f g  >/dev/null 2>&1



print_passed() {
  echo "Passed $3"
}

print_failed() {
  echo "Failed $3"
  exit 1
}

# Variable to track the overall test result
all_tests_passed=true

# Run test1
test_1=$(./pigs-init)
outcome_1="Initialized empty pigs repository in .pig"
echo "./pigs-init"
echo "$test_1"

if [ ! "$test_1" = "$outcome_1" ]; then
  print_failed
  all_tests_passed=false
fi

# Run test2 - edit a in working directory
test_2=$(echo hello >a)
outcome_2=""
echo "echo hello >a"

# Run test3 - add a to index
test_3=$(./pigs-add a)
echo "./pigs-add a"


# Run test4 - first commit
test_4=$(./pigs-commit -m "first commit")
outcome_4="Committed as commit 0"
echo "./pigs-commit -m "first commit""
echo "$test_4"

if [ ! "$test_4" = "$outcome_4" ]; then
  print_failed
  all_tests_passed=false
fi



# Run test5 - edit b in working directory
test_2=$(echo world >b)
outcome_2=""
echo "echo world >b"

# Run test6 - add b to index, again
test_3=$(./pigs-add b)
echo "./pigs-add b"

# Run test7 - second commit
test_4=$(./pigs-commit -m "second commit")
outcome_4="Committed as commit 1"
echo "./pigs-commit -m "second commit""
echo "$test_4"

if [ ! "$test_4" = "$outcome_4" ]; then
  print_failed
  all_tests_passed=false
fi


#Run test8 - pig-status

test_8=$(./pigs-status | grep -v "^pigs")
outcome_8="a - same as repo\nb - same as repo"
echo $test_8

# echo -n "$test_8" | od -c
# echo -n "$outcome_8" | od -c

if [ ! "$(echo "$test_8" | tr -d '[:space:]')" = "$(echo "$outcome_8" | tr -d '[:space:]')" ]; then
  print_failed
  all_tests_passed=false
fi


# Print overall result
if [ "$all_tests_passed" = true ]; then
  echo "passed $3"
fi