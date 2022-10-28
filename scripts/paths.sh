#!/bin/sh

# Find the project root directory.
PROJECT_PATH=`cd ${0%/*}/.. && pwd -P`


# Define output/source paths.
OUTPUT_PATH=$PROJECT_PATH/output
SOURCE_PATH=$PROJECT_PATH/source

OUTPUT_ROOT_NAME=root # The archive root.
OUTPUT_ROOT_PATH=$OUTPUT_PATH/$OUTPUT_ROOT_NAME
