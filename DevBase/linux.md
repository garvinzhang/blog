# linux

- SHELL 切换 root 用户

```bash
su root
```

- env

```bash
export RootPWD="xxxxx"
echo $RootPWD
```

- zsh

安装并配置 oh-my-zsh

```zsh
# 安装ZSH
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)" \
    && cd ~/.oh-my-zsh/custom/plugins/ \
    && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
    && git clone https://github.com/zsh-users/zsh-autosuggestions.git \
    && cd ~

# 配置zsh
sed -i 's/robbyrussell/ys/' ~/.zshrc
sed -i 's/plugins=(git)/plugins=(git zsh-syntax-highlighting zsh-autosuggestions)/' ~/.zshrc
```

- alias

```bash
# 自定义命令
vim ~/.bashrc
alias vim="nvim"
alias python="/src/bin/python3"
```

- ps

```bash
# 通过进程名称关闭进程
ps ax | grep 'main.py' | grep -v grep | awk '{print $1}' | xargs kill
# TKEx平台的进程存活监测
ps -ef | grep main.py | grep -v grep
```

- grep

```bash
# 基于特定后缀文件的查找
grep -r "insert into" *.py
```

- zip

```bash
# 压缩
zip abc.zip abc.file  # 压缩一个文件
zip test.zip install.log install.log.syslog  # 压缩多个文件
zip -r dir.zip dir/  # 压缩文件夹

# 解压缩 文件名乱码问题
unzip -O cp936 xxx.zip
```
