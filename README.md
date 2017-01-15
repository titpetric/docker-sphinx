# sphinx search

修改自https://github.com/leodido/dockerfiles

## 暴露端口

9312 for client connections

9306 for SQL connections

## 挂载点

/var/idx/sphinx

/var/log/sphinx

/var/lib/sphinx

/var/run/sphinx

/var/diz/sphinx

这些都在Dockerfile里定义成了data volumes

## 配置文件

/usr/local/etc/sphinx.conf

可以映射覆盖这个文件

## CMD

```bash
indexer --all
searchd --nodetach
```

## docker-compose
