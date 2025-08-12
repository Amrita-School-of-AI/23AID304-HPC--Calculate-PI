#!/bin/bash

# --- Performance Speedup Test Script ---
# This script compares the execution time of a student's parallel program
# against the original serial version from the initial Git commit.

# Exit immediately if any command fails
set -e

# echo "➡️  Starting performance test..."

# 1. Measure the execution time of the student's parallel code.
#    We assume the code has already been compiled into an executable named 'pi_calculator'.
# echo "   Running student's parallel version..."
gcc -o pi_calculator pi_calculator.c -fopenmp -lm
PARALLEL_TIME=$(./pi_calculator | grep 'Execution time' | awk '{print $3}')
if [ -z "$PARALLEL_TIME" ]; then
    # echo "❌ Error: Could not extract parallel execution time."
    exit 1
fi
# echo "   Parallel time: ${PARALLEL_TIME}s"


# 2. Get the original serial version of the code.
# echo "   Fetching the original serial code..."
# Find the hash of the very first commit in the repository.
INITIAL_COMMIT=$(git rev-list --max-parents=0 HEAD)
# Temporarily revert pi_calculator.c to its state in that initial commit.
git checkout "${INITIAL_COMMIT}" -- pi_calculator.c


# 3. Compile and run the serial version to measure its execution time.
# echo "   Compiling and running the serial version..."
# Compile the original file into a new executable named 'pi_serial'.
# The -lm flag links the math library.
gcc -fopenmp -o pi_serial pi_calculator.c -lm
SERIAL_TIME=$(./pi_serial | grep 'Execution time' | awk '{print $3}')
if [ -z "$SERIAL_TIME" ]; then
    # echo "❌ Error: Could not extract serial execution time."
    # Restore student's file before exiting
    git checkout HEAD -- pi_calculator.c
    exit 1
fi
# echo "   Serial time: ${SERIAL_TIME}s"


# 4. Clean up by restoring the student's modified file.
# echo "   Restoring student's file..."
git checkout HEAD -- pi_calculator.c


# 5. Compare the two execution times and print the result.
# echo "   Comparing results..."
# # Use 'bc -l' to compare the floating-point numbers.
# It will output '1' (true) if the parallel time is less than the serial time.
SPEEDUP_CHECK=$(echo "${PARALLEL_TIME} < ${SERIAL_TIME}" | bc -l)

if [ "${SPEEDUP_CHECK}" -eq 1 ]; then
  echo "Success: Parallel version is faster."
else
  echo "Failure: Parallel version is not faster than the serial version."
fi
