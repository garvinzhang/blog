# docker

- 构建镜像和挂载容器

```bash
# 基于dockerfile构建镜像
docker build -t {ImageNAME}:{TAG} -f Dockerfile .

# {LocalPATH}和{ContainerPATH}需要是绝对路径
docker run -it --name {ContainerNAME} -v {LocalPATH}:{ContainerPATH} {ImageNAME}:{TAG} /bin/bash
```

- 启动、关闭容器

```bash
docker start ${ContainerNAME}
docker stop ${ContainerNAME}
```

- 普通用户 权限问题

```bash
# 在rootUser执行
su
gpasswd -a normalUser docker
```
