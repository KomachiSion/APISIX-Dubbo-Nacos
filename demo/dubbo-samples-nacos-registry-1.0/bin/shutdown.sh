#!/bin/bash

cd `dirname $0`/../target
target_dir=`pwd`

pid=`ps ax | grep ${target_dir} | grep java | grep -v grep | awk '{print $1}'`
if [ -z "$pid" ] ; then
        echo "No nacos-dubbo-samples running."
        exit -1;
fi

echo "The nacos-dubbo-samples(${pid}) is running..."

kill ${pid}

echo "Send shutdown request to nacos-dubbo-samples(${pid}) OK"
