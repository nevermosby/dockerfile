#!/bin/sh
WORK_DIR=/home/open-falcon

cd $WORK_DIR/links
echo "links"
virtualenv ./env
./env/bin/pip install -r pip_requirements.txt
echo "links finish"