#!/bin/sh

# Source path definitions.
. `cd ${0%/*} && pwd -P`/paths.sh
cd $PROJECT_PATH # Switch to project root.


ADDON_NAME="hm-cf-tunnel"
ADDON_VERSION=$(cat VERSION)

# Name of the resulting addon archive.
ADDON_FILE_NAME=$ADDON_NAME-$ADDON_VERSION.tar.gz


echo "build $ADDON_NAME (version=$ADDON_VERSION)"; echo


echo "importing source files ..."
mkdir -p $OUTPUT_PATH $OUTPUT_ROOT_PATH
cp -f $SOURCE_PATH/install.sh $OUTPUT_ROOT_PATH/update_script
cp -rf $SOURCE_PATH/$ADDON_NAME* $OUTPUT_ROOT_PATH/
cp -f VERSION $OUTPUT_ROOT_PATH/$ADDON_NAME/


echo "compressing build output into addon ..."
cd $OUTPUT_PATH && tar --owner=root --group=root \
    -czf $ADDON_FILE_NAME $OUTPUT_ROOT_NAME/* \
    --transform=s:$OUTPUT_ROOT_NAME/::g

echo "removing temporary build files ..."
# rm -rf $OUTPUT_ROOT_PATH


echo; echo "done building '$ADDON_FILE_NAME'"
