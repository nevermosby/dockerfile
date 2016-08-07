#!/bin/sh
WORK_DIR=/home/open-falcon

REDIS_HOST_VALUE=127.0.0.1
MYSQL_HOST_VALUE=127.0.0.1
DOCKER_HOST_IP_VALUE=127.0.0.1

if [[ -n "$REDIS_HOST" ]]; then
    REDIS_HOST_VALUE=$REDIS_HOST
fi
if [[ -n "$MYSQL_HOST" ]]; then
    MYSQL_HOST_VALUE=$MYSQL_HOST
fi
if [[ -n "$DOCKER_HOST_IP" ]]; then
    DOCKER_HOST_IP_VALUE=$DOCKER_HOST_IP
fi

echo $REDIS_HOST_VALUE
echo $MYSQL_HOST_VALUE
echo $DOCKER_HOST_IP_VALUE


# config copy
rm $WORK_DIR/dashboard/rrd/config.py
ln -s $WORK_DIR/config/dashboard.config.py $WORK_DIR/dashboard/rrd/config.py

rm $WORK_DIR/portal/frame/config.py
ln -s $WORK_DIR/config/portal.config.py $WORK_DIR/portal/frame/config.py

rm $WORK_DIR/links/frame/config.py
ln -s $WORK_DIR/config/links.config.py $WORK_DIR/links/frame/config.py



# sender
sed -i "s/REDIS_HOST/$REDIS_HOST_VALUE/g" $WORK_DIR/cfg/sender.cfg.json

# judge
sed -i "s/REDIS_HOST/$REDIS_HOST_VALUE/g" $WORK_DIR/cfg/judge.cfg.json

# alarm
sed -i "s/REDIS_HOST/$REDIS_HOST_VALUE/g" $WORK_DIR/cfg/alarm.cfg.json

# graph
sed -i "s/MYSQL_HOST/$MYSQL_HOST_VALUE/g" $WORK_DIR/cfg/graph.cfg.json

# fe
sed -i "s/REDIS_HOST/$REDIS_HOST_VALUE/g" $WORK_DIR/cfg/fe.cfg.json
sed -i "s/MYSQL_HOST/$MYSQL_HOST_VALUE/g" $WORK_DIR/cfg/fe.cfg.json
sed -i "s/DOCKER_HOST_IP/$DOCKER_HOST_IP_VALUE/g" $WORK_DIR/cfg/fe.cfg.json

# dashboard
sed -i "s/MYSQL_HOST/$MYSQL_HOST_VALUE/g" $WORK_DIR/config/dashboard.config.py
rm $WORK_DIR/dashboard/rrd/config.py
ln -s $WORK_DIR/config/dashboard.config.py $WORK_DIR/dashboard/rrd/config.py
rm $WORK_DIR/dashboard/gunicorn.conf
ln -s $WORK_DIR/config/dashboard.gunicorn.conf $WORK_DIR/dashboard/gunicorn.conf

# portal
sed -i "s/MYSQL_HOST/$MYSQL_HOST_VALUE/g" $WORK_DIR/config/portal.config.py
sed -i "s/DOCKER_HOST_IP/$DOCKER_HOST_IP_VALUE/g"  $WORK_DIR/config/portal.config.py
rm $WORK_DIR/portal/frame/config.py
ln -s $WORK_DIR/config/portal.config.py $WORK_DIR/portal/frame/config.py
rm $WORK_DIR/portal/gunicorn.conf
ln -s $WORK_DIR/config/portal.gunicorn.conf $WORK_DIR/portal/gunicorn.conf

# HBS
sed -i "s/MYSQL_HOST/$MYSQL_HOST_VALUE/g" $WORK_DIR/cfg/hbs.cfg.json

# links
sed -i "s/MYSQL_HOST/$MYSQL_HOST_VALUE/g" $WORK_DIR/config/links.config.py
rm $WORK_DIR/links/frame/config.py
ln -s $WORK_DIR/config/links.config.py $WORK_DIR/links/frame/config.py
rm $WORK_DIR/links/gunicorn.conf
ln -s $WORK_DIR/config/links.gunicorn.conf $WORK_DIR/links/gunicorn.conf




supervisorctl start transfer
supervisorctl start agent
supervisorctl start graph
supervisorctl start query
supervisorctl start dashboard


supervisorctl start sender
supervisorctl start fe
supervisorctl start portal
supervisorctl start hbs
supervisorctl start judge
supervisorctl start alarm
supervisorctl start links

