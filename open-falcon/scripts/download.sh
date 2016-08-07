#!/bin/sh
WORK_DIR=/home/open-falcon
# OPEN_FALCON_TAR="http://192.168.0.102:8080/of-release-v0.1.0.tar.gz"
OPEN_FALCON_TAR="https://github.com/open-falcon/of-release/releases/download/v0.1.0/open-falcon-v0.1.0.tar.gz"

cd $WORK_DIR
mkdir tmp
wget $OPEN_FALCON_TAR -O open-falcon-latest.tar.gz
tar -zxf open-falcon-latest.tar.gz -C tmp/
for x in `find ./tmp/ -name "*.tar.gz"`;do \
    app=`echo $x|cut -d '-' -f2`; \
    mkdir -p $app; \
    tar -zxf $x -C $app; \
done