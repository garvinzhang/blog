# 增强版 mysql

## 01 连接数据库

```go
import (
    "fmt"
    _ "github.com/go-sql-driver/mysql"
    "github.com/jmoiron/sqlx"
)
type Userinfo struct {
    Id      int64  `json:"id"`
    Name    string `json:"name"`
    Phone   string `json:"phone"`
    Address string `json:"address"`
}
func main() {
    dsn := "root:rootroot@tcp(127.0.0.1:3306)/go_mysql_demo?charset=utf8mb4&parseTime=True"
    // 使用 MustConnect 连接的话，验证失败不成功直接panic
    //db := sqlx.MustConnect("mysql"， dsn)

    //使用 Connect 连接，会验证是否连接成功，
    db， err := sqlx.Connect("mysql"， dsn)

    if err != nil {
        fmt.Printf("connect DB failed， err:%v\n"， err)
        return
}
    db.SetMaxOpenConns(20)
    db.SetMaxIdleConns(10)
}
```

## 02 查询操作

查询单行数据

```go
sqlStr := "SELECT id，`name`，phone，address from userinfo where id = ?;"
var user Userinfo
err = db.Get(&user， sqlStr， 1)
if err != nil {
    fmt.Println("查询失败:"， err)
    return
}
fmt.Println("user:"，user)
```

查询多行数据

```go
sqlStr := "SELECT id，`name`，phone，address from userinfo where id >= ?"
var userList []Userinfo
err = db.Select(&userList， sqlStr， 1)
if err != nil {
    fmt.Println("查询失败:"， err)
    return
}
fmt.Println("userList:"，userList)
```
