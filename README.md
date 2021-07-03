# RCore Tutorial V3

## 前置条件
- 安装`Docker`
- 安装`VSCode`
- 安装VSCode插件：`rust-analyzer`、`RISC-V Support`、`Remote - SSH`和`Remote - Containers`

## 搭建开发环境

### 构建Docker镜像

```
git clone https://github.com/yjcyxky/rCore-Tutorial-v3.git

cd rCore-Tutorial-v3

make build-docker
```

### 拉取现成镜像
```
docker pull nordata/rcore-tutorial-v3:latest
```

## 启动Docker镜像

```
# 注意：当前目录会挂载到容器中/app目录
make run-docker
```

## 打开VSCode，连接开发环境
1. `Remote - SSH`：使用`启动Docker镜像`步骤中输出的IP地址、用户名和密码连接容器
2. `Remote - Containers`：连接至正在运行的容器