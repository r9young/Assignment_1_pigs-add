#!/bin/bash

# Function to run a command and capture its output
run_command() {
    output=$(eval "$1")
    echo "$output"
}

# Function to test pigs-init
test_pigs_init() {
    # Create a temporary directory and navigate into it
    temp_dir=$(mktemp -d)
    cd "$temp_dir"

    # Run the command
    output=$(run_command "pigs-init")

    # Check the output
    if [ "$output" == "Initialized empty pigs repository in .pig" ]; then
        echo "pigs-init test passed"
    else
        echo "pigs-init test failed"
    fi

    # Cleanup
    cd ..
    rm -rf "$temp_dir"
}

# Function to test pigs-status
test_pigs_status() {
    # Create a temporary directory and navigate into it
    temp_dir=$(mktemp -d)
    cd "$temp_dir"

    # Setup
    run_command "pigs-init"
    run_command "touch a b c d e f g h"
    run_command "pigs-add a b c d e f"
    run_command "pigs-commit -m 'first commit'"
    run_command "echo hello >a"
    run_command "echo hello >b"
    run_command "echo hello >c"
    run_command "pigs-add a b"
    run_command "echo world >a"
    run_command "rm d"
    run_command "pigs-rm e"
    run_command "pigs-add g"

    # Run the command
    output=$(run_command "pigs-status")

    # Check the output
    expected_output="a - file changed, different changes staged for commit
b - file changed, changes staged for commit
c - file changed, changes not staged for commit
d - file deleted
e - file deleted, deleted from index
f - same as repo
g - added to index
h - untracked"

    if [ "$output" == "$expected_output" ]; then
        echo "pigs-status test passed"
    else
        echo "pigs-status test failed"
    fi

    # Cleanup
    cd ..
    rm -rf "$temp_dir"
}

# Run the tests
test_pigs_init
test_pigs_status
