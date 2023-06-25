---
title: '在 Nginx 的容器中开启 debug 模式'
date: 2023-06-25 10:30:00 +0900
categories: ['技术分享']
tags: ['nginx', 'debug']
published: true
---

在使用 Nginx 的容器时候，需要开启 debug 日志来进行错误排查。

## 步骤 1： 使用 nginx-debug 来启动容器

```sh
$ docker run --name my-nginx -v /host/path/nginx.conf:/etc/nginx/nginx.conf:ro -d nginx nginx-debug -g 'daemon off;'
```

或者当使用 docker compose 时:

```yml
web:
  image: nginx
  volumes:
    - ./nginx.conf:/etc/nginx/nginx.conf:ro
  command: [nginx-debug, '-g', 'daemon off;']
```

## 步骤 2： 在配置文件中启用 debug 日志

```conf
server {
  error_log logs/error.log debug;
}
```
{: file='nginx.conf' }

## 参考资料

- [Docker - nginx](https://hub.docker.com/_/nginx){:target="_blank"}
- [Configuring Logging \| NGINX Documentation](https://docs.nginx.com/nginx/admin-guide/monitoring/logging/){:target="_blank"}
