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
searchd --nodetach
```

## docker-compose

默认的cmd是searchd.sh，第一次运行需要创建索引，command要用indexall.sh，后面可以注释这行，用默认的

创建/song/sphinx/文件夹，把sphinx.conf复制进去

```yml

version: '2'
services:
  sphinx:
    image: philoles/sphinx:2.2.10
    ports:
      - "9312:9312"
      - "9306:9306"
    volumes:
      - /song/sphinx/idx:/var/idx/sphinx
      - /song/sphinx/log:/var/log/sphinx
      - /song/sphinx/lib:/var/lib/sphinx
      - /song/sphinx/run:/var/run/sphinx
      - /song/sphinx/diz:/var/diz/sphinx
      - /song/sphinx/sphinx.conf:/usr/local/etc/sphinx.conf
    restart: always
    container_name: sphinx
    hostname: sphinx
    networks:
      - song
    command: ["indexall.sh"]

networks:
  song:
    external: true 

```

