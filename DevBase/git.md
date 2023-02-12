# git

- 免密登陆

```bash
# 查看git配置
git config --list
# 设置密码保存
git config --global credential.helper store
# 首次使用需要输入密码
git config --global user.email "xxx@xxx.com"
git config --global user.name "xxx"
```

- 提交规范

| 提交标签 | 意义                                              |
| :------- | ------------------------------------------------- |
| feat     | 新功能（feature）                                 |
| fix      | 修补 bug                                          |
| docs     | 文档（documentation）                             |
| style    | 格式（不影响代码运行的变动）                      |
| refactor | 重构（即不是新增功能，也不是修改 bug 的代码变动） |
| test     | 增加测试                                          |
| chore    | 构建过程或辅助工具的变动                          |

- 子模块

```bash
# 为项目添加子模块 - 模拟器采集框架子模块
git submodule add https://xxx.git
# 克隆项目时同时克隆项目的子模块
git clone --recursive https://xxx.git
# 更新所有的子模块
git submodule update --remote
```
