# MyMongoDB

# 教程链接
1. MongoDB 教程 | 菜鸟教程
    * https://www.runoob.com/mongodb/mongodb-tutorial.html
2. MongoDB 教程_w3cschool
    * https://www.w3cschool.cn/mongodb/
1. 全局备份和增量备份
    * https://www.cnblogs.com/hukey/p/11512062.html

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
`实例`
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

