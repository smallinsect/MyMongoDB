# **db.shutdownServer()**MyMongoDB

# 教程链接
1. MongoDB 教程 | 菜鸟教程
   
    * https://www.runoob.com/mongodb/mongodb-tutorial.html
    
2. MongoDB 教程_w3cschool
   
    * https://www.w3cschool.cn/mongodb/
    
1. 全局备份和增量备份
    * https://www.cnblogs.com/hukey/p/11512062.html
    - https://www.cnblogs.com/xuliuzai/p/9832333.html
    - https://www.cnblogs.com/xuliuzai/p/9917137.html
    
1. Windows上搭建MongoDB副本集
    - https://docs.mongodb.com/manual/tutorial/deploy-replica-set-for-testing/
    - https://www.cnblogs.com/s6-b/p/11128002.html
    - https://www.cnblogs.com/dadaokongkong/p/11919378.html
    - https://blog.csdn.net/wanght89/article/details/77677271
    - https://my.oschina.net/danjuan/blog/2999679
    - https://www.cnblogs.com/dennisit/archive/2013/01/28/2880166.html
    
1. Linux上搭建MongoDB副本集
    - https://blog.csdn.net/liu123641191/article/details/80963074
    - https://blog.csdn.net/weixin_34029680/article/details/93074653
    - https://segmentfault.com/a/1190000019753486
    - https://blog.csdn.net/caiqiandu/article/details/90051107
    - https://www.osyunwei.com/archives/9313.html
    
1. 问题
    - https://blog.csdn.net/weixin_43112000/article/details/83859413
    - https://www.jianshu.com/p/b5a7d13e1391
    
7. 节点切换
    - https://blog.csdn.net/weixin_34290631/article/details/90096649
    - https://blog.csdn.net/biao0309/article/details/95111946

8. 下载地址

    - https://www.mongodb.com/download-center/community



# Linux RedHat安装MongoDB

下载地址

```
https://www.mongodb.com/download-center/community
```

下载

```
curl -O https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-rhel80-4.2.7.tgz   # 下载
tar -zxvf mongodb-linux-x86_64-rhel80-4.2.7.tgz                                  # 解压
mv mongodb-linux-x86_64-rhel80-4.2.7/ /usr/local/mongodb           # 将解压包拷贝到指定目录
```

执行命令

```
/usr/local/mongodb/bin/mongod
/usr/local/mongodb/bin/mongo
```

添加环境变量

```
export PATH=<mongodb-install-directory>/bin:$PATH
<mongodb-install-directory> 为你 MongoDB 的安装路径。如本文的 /usr/local/mongodb 。
```



配置端口

```
27016 仲裁
27017 主
27018 次
27019 次

```

复制执行文件

```
cp -rf /usr/local/mongodb/bin/mongod /data/mongodb/mdb1/bin/mongod
cp -rf /usr/local/mongodb/bin/mongod /data/mongodb/mdb2/bin/mongod
cp -rf /usr/local/mongodb/bin/mongod /data/mongodb/mdb3/bin/mongod
cp -rf /usr/local/mongodb/bin/mongod /data/mongodb/mdb4/bin/mongod
```

启动服务器

```
/data/mongodb/mdb1/bin/mongod -f /data/mongodb/mdb1/mongod.conf
/data/mongodb/mdb2/bin/mongod -f /data/mongodb/mdb2/mongod.conf
/data/mongodb/mdb3/bin/mongod -f /data/mongodb/mdb3/mongod.conf
/data/mongodb/mdb4/bin/mongod -f /data/mongodb/mdb4/mongod.conf
```

连接数据库

```
/usr/local/mongodb/bin/mongo --port 27017
```

集群初始化

```
rscongfig={"_id":"rs0",
    members:[
        {_id:0,host:"localhost:27016",arbiterOnly:true},
        {_id:1,host:"localhost:27017"},
        {_id:2,host:"localhost:27018"},
        {_id:3,host:"localhost:27019"}
    ]
}
```

```
rs.initiate(rscongfig)
```

查看状态

```
rs.status()
```

查看配置

```
rs.conf()
```



# 常用命令
1. 连接数据库 mongo
1. 显示所有数据库 show dbs
1. 创建数据库 use mytest
1. 插入文档 db.mytest.insert({"name":"小昆虫"})
    * db.COLLECTION_NAME.insert(document)
1. 查询文档 db.mytest.find()
    * db.collection.find(query, projection)
1. 更新文档 db.collection.update()
    * db.col.update({'title':'MongoDB 教程'},{$set:{'title':'MongoDB'}})
1. 保存文档 db.collection.save()
    * db.col.save({
            "_id" : ObjectId("56064f89ade2f21f36b03136"),
            "title" : "MongoDB",
        })
1. 删除文档 db.collection.remove()
    * db.col.remove({'title':'MongoDB 教程'})
1. 条件操作符
1. $type 操作符
1. 指定数据量 limit()
1. 跳过 skip()
1. 排序 sort()
1. 索引 createIndex()
1. 聚合 aggregate() 管道
1. 删除数据库 db.dropDatabase()
```
show dbs
use cmt1
db.dropDatabase()
use cmt1-test
db.dropDatabase()
use cmt1Log
db.dropDatabase()
use test
db.dropDatabase()
use testLog
db.dropDatabase()
```
1. 查看集合 show tables
    * 
1. 创建集合 db.createCollection("runoobtt")
    * db.createCollection(name, options)
    * name: 要创建的集合名称
    * options: 可选参数, 指定有关内存大小及索引的选项
1. 删除集合 db.runoobtt.drop()
    * db.collection.drop()
1. 副本集设置
```
mongod --port "PORT" --dbpath "YOUR_DB_DATA_PATH" --replSet "REPLICA_SET_INSTANCE_NAME" 
```
```
实例 mongod --port 27017 --dbpath "E:\Program Files\MongoDB\Server\4.2\data" --replSet rs0
```
21. 分片
* 步骤一：启动Shard Server
```
mongod --port 27020 --dbpath=E:/data/shard/s0 --logpath=E:/data/shard/log/s0.log --logappend --fork
mongod --port 27021 --dbpath=E:/data/shard/s1 --logpath=E:/data/shard/log/s1.log --logappend --fork
mongod --port 27022 --dbpath=E:/data/shard/s2 --logpath=E:/data/shard/log/s2.log --logappend --fork
mongod --port 27023 --dbpath=E:/data/shard/s3 --logpath=E:/data/shard/log/s3.log --logappend --fork
```
* 步骤二： 启动Config Server
```
mkdir -p E:/data/shard/config
mongod --port 27100 --dbpath=E:/data/shard/config --logpath=E:/data/shard/log/config.log --logappend --fork
```
* 步骤三： 启动Route Process
```
mongos --port 40000 --configdb localhost:27100 --fork --logpath=E:/data/shard/log/route.log --chunkSize 500
```
mongos启动参数中，chunkSize这一项是用来指定chunk的大小的，单位是MB，默认大小为200MB.
* 步骤四： 配置Sharding
```
/usr/local/mongoDB/bin/mongo admin --port 40000
MongoDB shell version: 2.0.7
connecting to: 127.0.0.1:40000/admin
mongos> db.runCommand({ addshard:"localhost:27020" })
{ "shardAdded" : "shard0000", "ok" : 1 }
......
mongos> db.runCommand({ addshard:"localhost:27029" })
{ "shardAdded" : "shard0009", "ok" : 1 }
mongos> db.runCommand({ enablesharding:"test" }) #设置分片存储的数据库
{ "ok" : 1 }
mongos> db.runCommand({ shardcollection: "test.log", key: { id:1,time:1}})
{ "collectionsharded" : "test.log", "ok" : 1 }
```
* 步骤五： 程序代码内无需太大更改，直接按照连接普通的mongo数据库那样，将数据库连接接入接口40000

# 备份恢复
1. 全局备份
```
E:\data>mongodump -h dbhost -d dbname -o dbdirectory
-h：MongDB所在服务器地址，例如：127.0.0.1，当然也可以指定端口号：127.0.0.1:27017
-d：需要备份的数据库实例，例如：test
-o：备份的数据存放位置，例如：c:\data\dump，当然该目录需要提前建立，在备份完成后，系统自动在dump目录下建立一个test目录，这个目录里面存放该数据库实例的备份数据。
```
* 实例
```
E:\data>mongodump
```
2. 恢复
```
E:\data>mongorestore -h <hostname><:port> -d dbname <path>
--host <:port>, -h <:port>：MongoDB所在服务器地址，默认为： localhost:27017
--db , -d ：需要恢复的数据库实例，例如：test，当然这个名称也可以和备份时候的不一样，比如test2
--drop：恢复的时候，先删除当前数据，然后恢复备份的数据。就是说，恢复后，备份后添加修改的数据都会被删除，慎用哦！
<path>：mongorestore 最后的一个参数，设置备份数据所在位置，例如：c:\data\dump\test。
你不能同时指定 <path> 和 --dir 选项，--dir也可以设置备份目录。
--dir：指定备份的目录，你不能同时指定 <path> 和 --dir 选项。
```
实例
```
备份远程服务器的MongoDB数据库test到本地E:\data\dump目录下
> mongodump -h 192.168.3.64:27017 -d test -o E:\data\dump
数据库恢复，将备份好的test数据库恢复到本地MongoDB上。
> mongorestore -h 127.0.0.1:27017 -d test E:\data\dump\test
```

2. 增量备份

# 监控
1. mongostat

# 关系
1. 嵌入式关系
2. 引用式关系

# 数据库引用
1. DBRefs vs 手动引用

# 副本集群
1. 创建数据库目录
```
mkdir -p /data/mongodb/rs0-0 /data/mongodb/rs0-1 /data/mongodb/rs0-2
```
```
mkdir E:\data\mongodb\rs0-0 E:\data\mongodb\rs0-1 E:\data\mongodb\rs0-2
md E:\data\mongodb\rs0-0 E:\data\mongodb\rs0-1 E:\data\mongodb\rs0-2
```
2. 创建日志文件
```
touch /data/mongodb/rs0-0.log /data/mongodb/rs0-1.log /data/mongodb/rs0-2.log
```
```
type nul> E:\data\mongodb\rs0-0.log
type nul> E:\data\mongodb\rs0-1.log
type nul> E:\data\mongodb\rs0-2.log 
```
3. 创建3个mongod实例
```
mongod --bind_ip 0.0.0.0 --port 27017 --dbpath /data/mongodb/rs0-0 -fork --logpath /data/mongodb/rs0-0.log --replSet rs0 --smallfiles --oplogSize 128
mongod --bind_ip 0.0.0.0 --port 27018 --dbpath /data/mongodb/rs0-1 -fork --logpath /data/mongodb/rs0-1.log --replSet rs0 --smallfiles --oplogSize 128
mongod --bind_ip 0.0.0.0 --port 27019 --dbpath /data/mongodb/rs0-2 -fork --logpath /data/mongodb/rs0-2.log --replSet rs0 --smallfiles --oplogSize 128
```
```
mongod --bind_ip 0.0.0.0 --port 27017 --dbpath E:\data\mongodb\rs0-0 -fork --logpath E:\data\mongodb\rs0-0.log --replSet rs0 --oplogSize 128
mongod --bind_ip 0.0.0.0 --port 27018 --dbpath E:\data\mongodb\rs0-1 -fork --logpath E:\data\mongodb\rs0-1.log --replSet rs0 --oplogSize 128
mongod --bind_ip 0.0.0.0 --port 27019 --dbpath E:\data\mongodb\rs0-2 -fork --logpath E:\data\mongodb\rs0-2.log --replSet rs0 --oplogSize 128

md data\data1 data\data2
type nul > logs\dblog1.log
type nul > logs\dblog2.log
md key\key1.txt key\key2.txt 

mongod --replSet rs1 --keyFile=./key/key1.txt --port 8888 --dbpath=./data/data1/ --logpath=./logs/dblog1.log
mongod --replSet rs1 --keyFile=./key/key2.txt --port 8889 --dbpath=./data/data2/ --logpath=./logs/dblog2.log
参数说明
--replSet rs1副本集的名字
```


# MongoDB安装服务
1. 创建配置文件
```
systemLog:
    destination: file
    path: c:\data\log\mongod.log
storage:
    dbPath: c:\data\db
```
2. 安装服务
```
mongod.exe --config "E:\mongo\mongod.cfg" --install
mongod.exe --config mongod.cfg --install
mongod --config "E:\mongo\mongo1\mongod.cfg" --install
mongod --config "E:\mongo\mongo2\mongod.cfg" --install
mongod --config "E:\mongo\mongo3\mongod.cfg" --install

mongod --config "E:\mongo\mongo1\mongod.cfg" --serviceName "MongoDB1" --serviceDisplayName "MongoDB1" --install
mongod --config "E:\mongo\mongo2\mongod.cfg" --serviceName "MongoDB2" --serviceDisplayName "MongoDB2" --install
mongod --config "E:\mongo\mongo3\mongod.cfg" --serviceName "MongoDB3" --serviceDisplayName "MongoDB3" --install

mongod.exe --logpath D:\mongodb\logs\mongodb.log --logappend --dbpath D:\mongodb\data --directoryperdb --serviceName MongoDB --install
```
3. 启动服务
```
net start MongoDB
net start MongoDB1
net start MongoDB2
net start MongoDB3
```
4. 关闭服务
```
net stop MongoDB
net stop MongoDB1
net stop MongoDB2
net stop MongoDB3

db.shutdownServer()
```
5. 移除服务
```
mongod.exe --remove
mongod --remove --serviceName MongoDB
mongod --remove --serviceName MongoDB1
mongod --remove --serviceName MongoDB2
mongod --remove --serviceName MongoDB3
```
```
查看服务
sc query |findstr "MongoDB"
```
# MongoDB副本集搭建
1. 配置
```
processManagement:
    fork: true
    pidFilePath: ../mongod.pid
net: 
    bindIp: 0.0.0.0
    port: 27019
    maxIncomingConnections: 65536  
    wireObjectCheck: true 
    ipv6: false
storage:
    dbPath: ../data
    indexBuildRetry: true
    journal:
        enabled: true
systemLog:
    path: ../logs/mongodb.log
    logAppend: true
    destination: file
replication:
    oplogSizeMB: 10240
    replSetName: myrepl
    secondaryIndexPrefetch: all
security:
    authorization: enabled
    clusterAuthMode: keyFile
    keyFile: ../../mongodb.key
    javascriptEnabled: true
```
```
systemLog:
  destination: file
  logAppend: true
  path: /data/mongodb/logs/mongod.log

storage:
  dbPath: /data/mongodb/data
  journal:
    enabled: true
  directoryPerDB: true
  wiredTiger:
     engineConfig:
        cacheSizeGB: 8                    #如果一台机器启动一个实例这个可以注释选择默认，如果一台机器启动多个实例，需要设置内存大小，避免互相抢占内存
        directoryForIndexes: true

processManagement:
  fork: true
  pidFilePath: /data/mongodb/pid/mongod.pid

net:
  port: 27020
  bindIp: 10.1.1.159,localhost      #修改为本机IP地址
  maxIncomingConnections: 5000

#security:
  #keyFile: /data/mongodb/conf/keyfile
  #authorization: enabled
replication:
#   oplogSizeMB: 1024
   replSetName: rs02
```

1. 生成keyFile文件
```
openssl rand -base64 735 > mongodb.key
chmod 600 mongodb.key
```
3. 分别启动各个节点mongodb实例
```
./mongod -f ../mongod.conf//进入mongodb的bin目录下
mongod -f mongod.conf
mongod --replSet rs0 --port 27017 --dbpath E:\mongo\mongo1\data --smallfiles --oplogSize 128
mongod --replSet rs0 --port 27018 --dbpath E:\mongo\mongo2\data --smallfiles --oplogSize 128
mongod --replSet rs0 --port 27019 --dbpath E:\mongo\mongo3\data --smallfiles --oplogSize 128
测试能使用
mongod --replSet rs0 --port 27017 --dbpath E:\mongo\mongo1\data
mongod --replSet rs0 --port 27018 --dbpath E:\mongo\mongo2\data
mongod --replSet rs0 --port 27019 --dbpath E:\mongo\mongo3\data

```
1. 通过mongo shell连接到您的mongod实例之一。您将需要通过指定其端口号来指示哪个实例
```
C:\Users\78204>mongo --port 27017
MongoDB shell version v4.0.9
connecting to: mongodb://127.0.0.1:27017/?gssapiServiceName=mongodb
Implicit session: session { "id" : UUID("159b56d2-00cc-47e0-a7a5-2498c6661e29") }
MongoDB server version: 4.0.9
```
2. 您可以在mongo shell环境中创建一个副本集配置对象，如下面的示例所示
```
rsconf = {
  _id: "rs0",
  members: [
    {
     _id: 0,
     host: "127.0.0.1:27021"
    },
    {
     _id: 1,
     host: "127.0.0.1:27022"
    },
    {
     _id: 2,
     host: "127.0.0.1:27023"
    }
   ]
}
```
3. 使用rs.initiate()初始化副本集,然后将rsconf文件传递给rs.initiate()，如下所示
```
rs.initiate(rsconf)
```
4. 我们现在检查副本集的状态以便检查它是否被正确设置
```
rs.status()
rs.status()  ，执行后打印类似以下json返回值
    health：1   //1表明状态是正常，0表明异常
    state:1     // 1表明是primary，2表明是slave，即做备份的机器
```
5. 如何判断主节点和辅助节点  ：
```
db.isMaster()
```
6. 验证副本集数据的一致性

1. windows的数据库集群
``` 
mongod --replSet rs0 --port 27021 --dbpath E:\mongo\mongo1\data
mongod --config "E:\mongo\mongo1\mongod.cfg" --serviceName "MongoDB1" --serviceDisplayName "MongoDB1" --install

mongod --replSet rs0 --port 27022 --dbpath E:\mongo\mongo2\data
mongod --config "E:\mongo\mongo2\mongod.cfg" --serviceName "MongoDB2" --serviceDisplayName "MongoDB2" --install

mongod --replSet rs0 --port 27023 --dbpath E:\mongo\mongo3\data
mongod --config "E:\mongo\mongo3\mongod.cfg" --serviceName "MongoDB3" --serviceDisplayName "MongoDB3" --install
net start MongoDB1
net start MongoDB2
net start MongoDB3
net stop MongoDB1
net stop MongoDB2
net stop MongoDB3
mongod --remove --serviceName MongoDB1
mongod --remove --serviceName MongoDB2
mongod --remove --serviceName MongoDB3
```
mongo shell环境中创建一个副本集配置对象
```
rscongfig={"_id":"rs0",
    members:[
        {_id:0,host:"localhost:27021"},
        {_id:1,host:"localhost:27022"},
        {_id:2,host:"localhost:27023"}
    ]
}
```
使用rs.initiate()初始化副本集,然后将rsconf文件传递给rs.initiate()
```
rs.initiate(rscongfig)
```
连接数据库，指定端口
```
mongo --port 27021
```
我们现在检查副本集的状态以便检查它是否被正确设置
```
rs.status()
```
```
如何判断主节点和辅助节点  ：  db.isMaster()
```
验证副本集数据的一致性
```

```
设置副节点可读数据权限
```
db.getMongo().setSlaveOk()
rs.slaveOk()
```
- 移除一台服务器
```
你要连接到第二个成员的mongo实例 通过mongo+端口号
执行以下命令 db.shutdownServer()
```
```
接着你要连接到主节点mongoshell
执行以下命令来移除该成员 rs.remove("127.0.0.1:27022")
```
添加一台服务器
```
连接到主节点(27017)的mongoshell控制台，将这个新成员添加到副本集 rs.add("127.0.0.1:27020")
```
- 将第两个个从节点设置为仲裁节点，也就是将127.0.0.1:27112，127.0.0.1:27113设置为仲裁节点，首先删除原始的第二个从节点：
```
rs.remove("127.0.0.1:27021")
rs.remove("127.0.0.1:27022")
rs.remove("127.0.0.1:27023")

rs.add("127.0.0.1:27021")
rs.add("127.0.0.1:27022")
rs.add("127.0.0.1:27023")
添加仲裁点
rs.addArb("127.0.0.1:27023")
```
- 重新设置副本集，参数
```
config_set={
    "_id":"rs0",
    members:[
            {_id:0,host:"127.0.0.1:27021"},
            {_id:1,host:"127.0.0.1:27022"},
            {_id:2,host:"127.0.0.1:27023",arbiterOnly:true}
    ]
}
```
- 然后执行
```
rs.reconfig(config_set)

```
- 再查看状态
```
rs.status()
```
- 看出从节点2的stateStr为ARBITER。至此，一主一丛一仲裁节点的副本集才创建完毕。
```
arps:PRIMARY> config=rs.conf()                //查看当前配置，存入config变量中。
arps:PRIMARY> config.members[2].priority = 3  //修改config变量，第三组成员的优先级为3.
arps:PRIMARY> rs.reconfig(config)             //配置生效 
arps:SECONDARY> rs.conf()  
```

# Linux下搭建副本集群
## 查看服务器命令
- 查看linux版本
```
cat /proc/version
```
- 创建文件夹
```
执行目录
mkdir -p /data/mongodb/mdb1/bin
mkdir -p /data/mongodb/mdb2/bin
mkdir -p /data/mongodb/mdb3/bin
mkdir -p /data/mongodb/mdb4/bin
数据目录
mkdir -p /data/mongodb/mdb1/data
mkdir -p /data/mongodb/mdb2/data
mkdir -p /data/mongodb/mdb3/data
mkdir -p /data/mongodb/mdb4/data
日志目录
mkdir -p /data/mongodb/mdb1/log
mkdir -p /data/mongodb/mdb2/log
mkdir -p /data/mongodb/mdb3/log
mkdir -p /data/mongodb/mdb4/log
复制执行文件
cp -fp /usr/bin/mongod /data/mongodb/mdb1/bin
cp -fp /usr/bin/mongod /data/mongodb/mdb2/bin
cp -fp /usr/bin/mongod /data/mongodb/mdb3/bin
cp -fp /usr/bin/mongod /data/mongodb/mdb4/bin
复制进程id文件
cp -fp /var/run/mongodb/mongod.pid /data/mongodb/mdb1/
cp -fp /var/run/mongodb/mongod.pid /data/mongodb/mdb2/
cp -fp /var/run/mongodb/mongod.pid /data/mongodb/mdb3/
cp -fp /var/run/mongodb/mongod.pid /data/mongodb/mdb4/
复制配置文件
cp -fp /etc/mongod.conf /data/mongodb/mdb1/
cp -fp /data/mongodb/mdb1/mongod.conf /data/mongodb/mdb2/
cp -fp /data/mongodb/mdb1/mongod.conf /data/mongodb/mdb3/
cp -fp /data/mongodb/mdb1/mongod.conf /data/mongodb/mdb4/
执行程序
/data/mongodb/mdb1/bin/mongod -f /data/mongodb/mdb1/mongod.conf
/data/mongodb/mdb2/bin/mongod -f /data/mongodb/mdb2/mongod.conf
/data/mongodb/mdb3/bin/mongod -f /data/mongodb/mdb3/mongod.conf
/data/mongodb/mdb4/bin/mongod -f /data/mongodb/mdb4/mongod.conf

杀掉进程
kill pid
rm -rf /data/mongodb/mdb1/bin/mongod
```
## 配置文件
```
mdb1 端口27017 主
mdb2 端口27018 仲裁
mdb3 端口27019 次
mdb4 端口27020 次
```

## 初始化
```
rscongfig={"_id":"rs0",
    members:[
        {_id:0,host:"localhost:27017"},
        {_id:1,host:"localhost:27018",arbiterOnly:true},
        {_id:2,host:"localhost:27019"},
        {_id:3,host:"localhost:27020"}
    ]
}
```
```
rs.initiate(rscongfig)
```
## 设置仲裁点
```
rs.add("localhost:27017")
rs.addArb("127.0.0.1:27023")
```
## 查看配置
```
rs.conf()
```
## 查看辅助节点数据
```
辅助节点初次同步数据会提示错误如下  解决方法如下 
rs.slaveOk() 或者 db.getMongo().setSlaveOk()
```
## 切换主副节点
```
arps:PRIMARY> config=rs.conf()                //查看当前配置，存入config变量中。
arps:PRIMARY> config.members[2].priority = 3  //修改config变量，第三组成员的优先级为3.
arps:PRIMARY> rs.reconfig(config)             //配置生效 
arps:SECONDARY> rs.conf()                    //查看当前配置
```

## 连接数据库
```
mongo --host 192.168.5.99 --port 27017
```

## 清除数据库所有数据

```
rm -rf /data/mongodb/mdb1/data/*
rm -rf /data/mongodb/mdb2/data/*
rm -rf /data/mongodb/mdb3/data/*
rm -rf /data/mongodb/mdb4/data/*
```

## 开启数据库服务

```
/data/mongodb/mdb1/bin/mongod -f /data/mongodb/mdb1/mongod.conf 
/data/mongodb/mdb2/bin/mongod -f /data/mongodb/mdb2/mongod.conf
/data/mongodb/mdb3/bin/mongod -f /data/mongodb/mdb3/mongod.conf
/data/mongodb/mdb4/bin/mongod -f /data/mongodb/mdb4/mongod.conf
```

## 数据库备份

```
mongodump -h 192.168.5.99:27017 -d test -o E:\data\dump
mongodump -h 192.168.5.99:27017 -d testLog -o E:\data\dump
mongodump -h 192.168.5.99:27017 -d cmt1-test -o E:\data\dump
mongodump -h 192.168.5.99:27017 -d cmt1-testLog -o E:\data\dump
mongodump -h 192.168.5.99:27017 -d cmt1 -o E:\data\dump
mongodump -h 192.168.5.99:27017 -d cmt1Log -o E:\data\dump
```

## 恢复数据库

```
mongorestore -h 192.168.5.99:27017 -d test E:\data\dump\test
mongorestore -h 192.168.5.99:27017 -d testLog E:\data\dump\testLog
mongorestore -h 192.168.5.99:27017 -d cmt1-test E:\data\dump\cmt1-test
mongorestore -h 192.168.5.99:27017 -d cmt1-testLog E:\data\dump\cmt1-testLog
mongorestore -h 192.168.5.99:27017 -d cmt1 E:\data\dump\cmt1
mongorestore -h 192.168.5.99:27017 -d cmt1Log E:\data\dump\cmt1Log
```

