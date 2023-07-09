#!/bin/dash

#init

rm -r ./.pig  >/dev/null 2>&1
rm a b c d e f g  >/dev/null 2>&1


print_passed() {
  echo "Passed $0"
}

print_failed() {
  echo "Failed $0"
  exit 1
}

# Variable to track the overall test result
all_tests_passed=true



# Run test0
test_0=$(./pigs-add c)
outcome_0="./pigs-add: error: pigs repository directory .pig not found"
echo "./pigs-add c"
echo "$test_0"

if [ ! "$test_0" = "$outcome_0" ]; then
  print_failed
  all_tests_passed=false
fi


# Run test1
test_1=$(./pigs-init)
outcome_1="Initialized empty pigs repository in .pig"
echo "./pigs-init"
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



# Print overall result
if [ "$all_tests_passed" = true ]; then
  echo "passed $0"
fi