# MyMongoDB


  

操作	| 格式  | 范例 | RDBMS中的类似语句  
--------|---------|-------  
等于 | {<key>:<value>} | db.col.find({"by":"菜鸟教程"}).pretty() | where by = '菜鸟教程'  
小于 | {<key>:{$lt:<value>}}	| db.col.find({"likes":{$lt:50}}).pretty() | where likes < 50  
小于或等于 | {<key>:{$lte:<value>}}	db.col.find({"likes":{$lte:50}}).pretty() | where likes <= 50  
大于 | {<key>:{$gt:<value>}}	db.col.find({"likes":{$gt:50}}).pretty() | where likes > 50  
大于或等于 | {<key>:{$gte:<value>}} | db.col.find({"likes":{$gte:50}}).pretty() | where likes >= 50  
不等于 | {<key>:{$ne:<value>}} | db.col.find({"likes":{$ne:50}}).pretty() | where likes != 50  
