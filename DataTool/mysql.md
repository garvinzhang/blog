# mysql

- 创建数据表模版

```sql
-- Template
id int(8) NOT NULL AUTO_INCREMENT COMMENT '自增计数',
 int(8) NOT NULL DEFAULT 0 COMMENT '',
 float NOT NULL DEFAULT 0 COMMENT '',
 varchar(64) NOT NULL DEFAULT '' COMMENT '',
 text COMMENT '',
date_ds int(4) NOT NULL DEFAULT 20010101 COMMENT '数据写入日期分区ds',
insert_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '插入时间',
update_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
PRIMARY KEY (id,date_ds),
index (insert_time)
```

- 增删改查

```sql
-- 获取字段的后几位
select SUBSTRING(userLink, -3) from db.table;

-- 增加 更新 删除
INSERT into db.table (account) values ("test_unique");
UPDATE db.table SET FirstName = 'Fred' WHERE LastName = 'Wilson';
DELETE FROM db.table WHERE FirstName = 'Fred';
```
