#!/bin/bash
 
host='192.168.5.99'
port='27017'
sourcepath='/usr/bin'
targetpath='/data/mongodb/mdbbackup'
nowtime=$(date "+%Y%m%d")

start(){
    $sourcepath/mongodump --host $host --port $port --oplog --gzip --out ${targetpath}/${nowtime}
}

execute(){
	echo "=========================$(date) backup all mongodb back start  ${nowtime}========="
	start
	if [ $? -eq 0 ];then
	    echo "The MongoDB BackUp Successfully!"
	else
	    echo "The MongoDB BackUp Failure"
	fi
}

if [ ! -d "${targetpath}/${nowtime}" ];then
    mkdir -p "${targetpath}/${nowtime}"
fi

execute

backtime=$(date -d '-7 days' "+%Y%m%d")
if [ -d "${targetpath}/${backtime}/" ];then
    rm -rf "${targetpath}/${backtime}/"
    echo "=======${targetpath}/${backtime}/===删除完毕=="
fi

echo "========================= $(date) backup all mongodb back end ${nowtime}========="
