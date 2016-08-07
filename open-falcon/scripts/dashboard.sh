#!/bin/sh
WORK_DIR=/home/open-falcon
echo "dashboard"
cd $WORK_DIR/dashboard

virtualenv ./env
./env/bin/pip install -r pip_requirements.txt 

echo "dashboard finish"