#!/bin/sh -e

# Go to pmbootstrap folder
DIR="$(cd "$(dirname "$0")" && pwd -P)"
cd "$DIR/.."

# Functions for pretty Travis output
. .travis/common.sh

# pmbootstrap log
fold_start "pmbootstrap log" "Printing pmbootstrap log file"
cat ~/.local/var/pmbootstrap/log.txt
fold_end "pmbootstrap log"

# Testsuite log
fold_start "testsuite log" "Printing testsuite log file"
cat ~/.local/var/pmbootstrap/log_testsuite.txt
fold_end "testsuite log"
