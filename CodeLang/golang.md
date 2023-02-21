# golang

> 建议开发环境基于 linux-docker 容器化

## 01 环境安装

下载并安装 GO 环境

```bash
wget https://go.dev/dl/go1.19.linux-amd64.tar.gz
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.19.linux-amd64.tar.gz

# vim ~/.bashrc
# 至于这里为什么这么配置, 可参考 https://learnku.com/go/t/39086#0b3da8
export GO111MODULE=on
# 把go命令以及gopath添加到path环境变量
export PATH=$PATH:/usr/local/go/bin:~/go/bin
```

## 02 技巧

- 如果结构体较大，传递结构体指针更合适，因为指针类型相比值类型能节省大量的内存空间
- 如果结构体较小，传递结构体更适合，因为在栈上分配内存，可以有效减少 GC 压力

### 协程间的通信 channel

发送数据到一个 channel 中，可能是顺序错乱的，另一个协程从 channel 中取数据，用列表存储，直到列表的值到达 2 个，最后对数据做处理，更高效。
例如 3 个 SQL，一个 SQL 需要用到前两个 SQL 的结果，前两个 SQL 结果并行，提升 SQL 查询效率。

```go
import (
   "fmt"
   "time"
)

func main() {
   ch := make(chan string)
   go sendData(ch)
   go getData(ch)
   time.Sleep(1e9)
}

func sendData(ch chan string){
  ch <- "golang"
}

func getData(ch chan string){
  fmt.Println(<- ch)
}
```

go 语言中 make 作用是为 slice、map、channel 分配内存并返回一个初始化的值，其使用方法有：1、【make(map[string]string)】；2、【make([]int, 2)】；3、【make([]int, 2, 4】。

## 03 mysql 数据库

单行查询

```go
sqlStr := "select id, name, age from user where id=?"
var u User
id := 1
// 非常重要:确保QueryRow之后调用Scan方法,否则持有数据的连接不会被释放
err := Db.QueryRow(sqlStr, id).Scan(&u.Id, &u.Name, &u.Age)
if err != nil {
    fmt.Printf("scan failed, err: %v\n", err)
    return
}
fmt.Printf("id: %d, name:%s, age:%d\n", u.Id, u.Name, u.Age)
```

多行查询

```go
sqlStr := "select id, name, age from user where id > ?"
userList := make([]User, 0, 120)
//userList := []User{1,"s", 3}

rows, err := Db.Query(sqlStr, id)
if err != nil {
    return
}
// 非常重要,关闭rows释放持有的数据库连接
defer rows.Close()
// 循环读取结果集中的数据
for rows.Next() {
    var u User
    err := rows.Scan(&u.Id, &u.Name, &u.Age)
    if err != nil {
        fmt.Printf("scan failed, err:%v\n", err)
        return
    }
    userList = append(userList, u)
    fmt.Printf("id: %d, name: %s, age: %d\n", u.Id, u.Name, u.Age)

}
fmt.Printf("%#v", userList)
```

插入数据

```go
sqlStr := "insert into user(name, age) values(?,?)"
ret, err := Db.Exec(sqlStr, name, age)
if err != nil {
    fmt.Printf("insert failed , err:%v\n", err)
    return
}
theId, err := ret.LastInsertId() // 新插入数据的id
if err != nil {
    fmt.Printf("get lastinsert Id failed, err: %v\n,", err)
}
fmt.Println("insert success, the id is:", theId)
```

更新数据

```go
	sqlStr := "update user set age=? where id=?"
	ret, err := Db.Exec(sqlStr, age, id)
	if err != nil {
		fmt.Printf("update failed, err: %v\n", err)
	}
	n, err := ret.RowsAffected() // 操作收影响的行
	if err != nil {
		fmt.Printf("get RowsAffected failed: %v\n", err)
		return
	}
	fmt.Printf("update success, affected rows: %d\n", n)
```

删除数据

```go
sqlStr := "delete from user where id=?"
ret, err := Db.Exec(sqlStr, id)
if err != nil {
    fmt.Printf("delete failed, err: %v\n", err)
    return
}
n, err := ret.RowsAffected() // 获取操作影响的行数
if err != nil {
    fmt.Printf("get RowsAffected fail, err:%v\n", err)
}
fmt.Printf("delete success, affected rows: %v \n", n)
```

### mysql 预处理 避免 SQL 注入的问题

查询数据

```go
id := 1

sqlStr := "select id, name, age from user where id > ?"
stmt, err := Db.Prepare(sqlStr)
if err != nil {
    fmt.Printf("preare failed, err: %v\n", err)
    return
}
defer stmt.Close()
rows, err := stmt.Query(id)
if err != nil {
    fmt.Printf("query failed, err:%v\n", err)
    return
}
defer rows.Close()
// 循环读取结果集中的数据
for rows.Next() {
    var u User
    err := rows.Scan(&u.Id, &u.Name, &u.Age)
    if err != nil {
        fmt.Printf("scan failed, err:%v\n", err)
        return
    }
    fmt.Printf("id:%d, name: %s, age:%d", u.Id, u.Name, u.Age)
}
```

exec 操作

```go
name := ""
age := 0

sqlStr := "insert into user(name, age) values(?, ?)"
stmt, err := Db.Prepare(sqlStr)
if err != err {
    fmt.Printf("prepare failed, err:%v\n", err)

}
defer stmt.Close()
ret, err := stmt.Exec(name, age)
if err != nil {
    fmt.Printf("insert failed, err: %d\n", err)
    return
}
n, err := ret.RowsAffected()
if err != nil {
    fmt.Printf("get RowsAffected failed err:%d", err)
}
fmt.Printf("insert sucesss n:%d", n)
```
