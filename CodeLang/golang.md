# golang

- 环境安装

```bash
# 切换到root用户
# 下载 Go 源码包，请保证下面的版本号是较新的
wget https://go.dev/dl/go1.19.linux-amd64.tar.gz
# 移除旧的已有安装，并解压出新的安装（需要 root 权限）
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.19.linux-amd64.tar.gz

# vim ~/.bashrc
# 至于这里为什么这么配置, 可参考 https://learnku.com/go/t/39086#0b3da8
export GO111MODULE=on
# 请点击以下链接, 进行设置go proxy和go sumdb:
https://goproxy.woa.com/
# 把go命令以及gopath添加到path环境变量
export PATH=$PATH:/usr/local/go/bin:~/go/bin

# go install git.code.oa.com/trpc-go/trpc-go-cmdline/trpc@latest
```
