#!/bin/sh
WORK_DIR=/home/open-falcon
cd $WORK_DIR/portal
echo "portal"
virtualenv ./env
./env/bin/pip install -r pip_requirements.txt
echo "portal finish"