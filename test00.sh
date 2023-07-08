#!/bin/dash
#init

./zclean_up.sh

print_passed() {
  echo "Passed $0"
}

print_failed() {
  echo "Failed $0"
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

if [ ! "$test_2" = "$outcome_2" ]; then
  print_failed
  all_tests_passed=false
fi




# Run test3
test_3=$(./pigs-init.sh)
outcome_3="./pigs-init.sh: error: .pig already exists"
echo "./pigs-init.sh"
echo "$test_3"

if [ ! "$test_3" = "$outcome_3" ]; then
  print_failed
  all_tests_passed=false
fi

# Print overall result
if [ "$all_tests_passed" = true ]; then
  echo "passed $0"
fi