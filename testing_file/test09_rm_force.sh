#!/bin/d


# init add commit rm --force

./test_cleanup.sh

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


test_2=$(echo world >b)
outcome_2=""
echo "echo world >a"

# Run test3 - add a to index
test_3=$(./pigs-add a)
echo "./pigs-add a"


# Run test4 - first commit
test_4=$(./pigs-commit -m "first commit")
outcome_4="Committed as commit 0"
echo "./pigs-commit -m "first commit""
echo "$test_4"



# Run test5 -  rm --force a
test_5=$(./pigs-rm --force b)
outcome_4="./pigs-rm: error: 'b' is not in the pigs repository"
echo "./pigs-rm --force b"
echo "$test_5"

if [ ! "$(echo "$test_8" | tr -d '[:space:]')" = "$(echo "$outcome_8" | tr -d '[:space:]')" ]; then
  print_failed
  all_tests_passed=false
fi

# Print overall result
if [ "$all_tests_passed" = true ]; then
  echo "passed $3"
fi
