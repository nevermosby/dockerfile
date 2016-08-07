#!/bin/sh
WORK_DIR=/home/open-falcon

useradd -m work
mkdir $WORK_DIR
mkdir $WORK_DIR/logs
mkdir $WORK_DIR/data

apt-get -y update
apt-get -y install git supervisor wget libmysqlclient-dev python-dev python-pip python-virtualenv

apt-get -y clean

