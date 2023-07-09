#!/bin/d
# init rm

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

# Run test2
test_2=$(echo hello >a)
outcome_2=""
echo "echo hello >a"

# Run test3
test_3=$(./pigs-add a)
echo "./pigs-add a"



# Run test4 - pig-rm
test_4=$(./pigs-rm c)
outcome_4="./pigs-rm: error: 'c' is not in the pigs repository"
echo "./pigs-init"
echo "$test_4"

if [ ! "$test_4" = "$outcome_4" ]; then
  print_failed
  all_tests_passed=false
fi




# Print overall result
if [ "$all_tests_passed" = true ]; then
  echo "passed $3"
fi



