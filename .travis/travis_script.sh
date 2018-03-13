#!/bin/sh -e

# Go to pmbootstrap folder
DIR="$(cd "$(dirname "$0")" && pwd -P)"
cd "$DIR/.."

# Functions for pretty Travis output
. .travis/common.sh

# Static code analysis
fold_start "static code analysis" "Static code analysis"
test/static_code_analysis.sh
fold_end "static code analysis"

# pmbootstrap init
fold_start "pmbootstrap init" "Initializing pmbootstrap with defaults"
yes "" | ./pmbootstrap.py init
fold_end "pmbootstrap init"

# pmbootstrap kconfig_check
fold_start "pmbootstrap kconfig_check" "Checking all kernel configs"
./pmbootstrap.py kconfig_check
fold_end "pmbootstrap kconfig_check"

# pmbootstrap build --strict
fold_start "pmbootstrap build --strict" \
	"Building all changed aports in strict mode"
test/check_checksums.py --build
fold_end "pmbootstrap build --strict"

# Testsuite
fold_start "testsuite" "Running the testsuite"
test/testcases_fast.sh --all
fold_end "testsuite"

