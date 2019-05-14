# Docker

开发阶段请勿使用

[Docker Hub](https://hub.docker.com/r/wxparcel/wxdt)

## 安装

```bash
$ docker push wxparcel/wxdt:tagname
```

## 执行

内部端口为 3000

```bash
$ docker run -p 3000:3000 wxparcel/wxdt:tagname
```

#### docker compose

```docker-compose.yml
version: "3"
services:
  wxdt:
    image: "wxparcel/wxdt:tagname"
    ports:
    - "3064:3000"
```

```bash
$ docker-compose up
```
