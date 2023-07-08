#!/bin/dash

./zclean_up.sh

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
test_1=$(./pigs-init.sh)
outcome_1="Initialized empty pigs repository in .pig"
echo "./pigs-init.sh"
echo "$test_1"

if [ ! "$test_1" = "$outcome_1" ]; then
  print_failed
  all_tests_passed=false
fi

# Run test2
test_2=$(echo hello >a)
outcome_2=""
echo "echo hello >a"

# Run test3
test_3=$(./pigs-add.sh a)
echo "./pigs-add.sh a"


# Run test4
test_4=$(./pigs-commit.sh -m "first commit")
outcome_4="Committed as commit 0"
echo "./pigs-commit.sh -m "first commit""
echo "$test_4"

if [ ! "$test_4" = "$outcome_4" ]; then
  print_failed
  all_tests_passed=false
fi

#
# Run test5
test_5=$(./pigs-commit.sh -m "second commit") #there is some issue in test 5, if we echo
outcome_5="nothing to commit" 
echo "./pigs-commit.sh -m "second commit""
echo "nothing to commit" 


if [ ! "$test_5" = "$outcome_5" ]; then
  print_failed
  all_tests_passed=false
fi


# Print overall result
if [ "$all_tests_passed" = true ]; then
  echo "passed $3"
fi



