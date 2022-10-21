#!/bin/sh

# Source path definitions.
. `cd ${0%/*} && pwd -P`/paths.sh
cd $PROJECT_PATH # Switch to project root.


# Clean output.
rm -rf $OUTPUT_PATH
