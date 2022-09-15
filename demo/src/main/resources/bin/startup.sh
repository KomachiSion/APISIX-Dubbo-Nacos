#!/bin/bash

SERVER_NAME=Nacos-Dubbo-samples

cd `dirname $0`
cd ..
DEPLOY_DIR=`pwd`

LOGS_DIR=${DEPLOY_DIR}/logs
if [ ! -d ${LOGS_DIR} ]; then
    mkdir ${LOGS_DIR}
fi

STDOUT_FILE=${LOGS_DIR}/stdout.log
EXT_LIB=${DEPLOY_DIR}/ext-lib

CLASS_PATH=.:${DEPLOY_DIR}/lib/*:${EXT_LIB}/*:${DEPLOY_DIR}/conf/*

JAVA_OPTS=" -Djava.awt.headless=true -Djava.net.preferIPv4Stack=true "

JAVA_MEM_OPTS=" -server -Xmx2g -Xms2g -Xmn1g -Xss1m -XX:+DisableExplicitGC -XX:+UseConcMarkSweepGC -XX:+CMSParallelRemarkEnabled -XX:LargePageSizeInBytes=128m -XX:+UseFastAccessorMethods -XX:+UseCMSInitiatingOccupancyOnly -XX:CMSInitiatingOccupancyFraction=70 "

MAIN_CLASS=org.apache.dubbo.samples.provider.ProviderBootstrap

print_usage() {
    echo "usage: start.sh [-f provider/consumer]"
    exit 0
}

while getopts ":h:f:" opt
do
    case $opt in
        h)
            print_usage;;
        f)
            FUNCTION_MODE=$OPTARG;;
        ?)
        echo "Unknown parameter"
        exit 1;;
    esac
done

if [[ "${FUNCTION_MODE}" == "provider" ]]; then
    MAIN_CLASS=org.apache.dubbo.samples.provider.ProviderBootstrap
elif [[ "${FUNCTION_MODE}" == "consumer" ]]; then
    MAIN_CLASS=org.apache.dubbo.samples.consumer.ConsumerBootstrap
fi

echo "Starting the $SERVER_NAME ..."
echo "The classpath is ${CLASS_PATH}"

nohup java ${JAVA_OPTS} ${JAVA_MEM_OPTS} -classpath ${CLASS_PATH} ${MAIN_CLASS} >> ${STDOUT_FILE} 2>&1 &
sleep 1
echo "Please check the STDOUT file: $STDOUT_FILE"
