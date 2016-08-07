#!/bin/sh
WORK_DIR=/home/open-falcon
if [[ -n "$REDIS_HOST" ]]; then
    # sender
    sed -i "s/127.0.0.1:6379/$REDIS_HOST:6379/g" $WORK_DIR/conf/sender.cfg.json
    # fe
    sed -i "s/127.0.0.1:6379/$REDIS_HOST:6379/g" $WORK_DIR/conf/fe.cfg.json
    # judge
    sed -i "s/127.0.0.1:6379/$REDIS_HOST:6379/g" $WORK_DIR/conf/judge.cfg.json
    # alarm
    sed -i "s/127.0.0.1:6379/$REDIS_HOST:6379/g" $WORK_DIR/conf/alarm.cfg.json

fi


if [[ -n "$MYSQL_HOST" ]]; then
    # graph
    sed -i "s/127.0.0.1:3306/$MYSQL_HOST:3306/g" $WORK_DIR/conf/graph.cfg.json
    
    # dashboard
    sed -i "/DASHBOARD_DB_HOST/c DASHBOARD_DB_HOST = \"$MYSQL_HOST\"" $WORK_DIR/dashboard/rrd/config.py
    sed -i "/GRAPH_DB_HOST/c GRAPH_DB_HOST = \"$MYSQL_HOST\"" $WORK_DIR/dashboard/rrd/config.py
    
    # fe
    sed -i "s/127.0.0.1:3306/$MYSQL_HOST:3306/g" $WORK_DIR/conf/fe.cfg.json

    # portal
    sed -i "/DB_HOST/c DB_HOST = \"$MYSQL_HOST\"" $WORK_DIR/portal/frame/config.py
    
    # HBS
    sed -i "s/127.0.0.1:3306/$MYSQL_HOST:3306/g" $WORK_DIR/conf/hbs.cfg.json
    
    # links
    sed -i "/DB_HOST/c DB_HOST = \"$MYSQL_HOST\"" $WORK_DIR/links/frame/config.py
fi

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

