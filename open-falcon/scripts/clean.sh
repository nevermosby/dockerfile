#!/bin/sh
WORK_DIR=/home/open-falcon
echo "clean"
rm $WORK_DIR/*.tar.gz
rm $WORK_DIR/tmp/*

apt-get -y clean
rm -rf /var/lib/apt/lists/*
rm -rf /tmp/*
rm -rf /var/tmp/*

chown -R work.work $WORK_DIR
echo "clean finish"
