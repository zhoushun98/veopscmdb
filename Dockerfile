# ================================= UI ================================
FROM node:16.20.2 AS ui-builder

LABEL maintainer="zhoushun98@hotmail.com"

ENV CMDB_VERSION 2.3.12

RUN set -x \
    && curl -fsSLOJ https://mirror.ghproxy.com/https://github.com/veops/cmdb/archive/refs/tags/"$CMDB_VERSION".tar.gz \
    && tar zxf cmdb-"$CMDB_VERSION".tar.gz \
    && cd cmdb-"$CMDB_VERSION"/cmdb-ui/ \
    && yarn config set registry https://registry.npmmirror.com \
    && yarn config set ignore-engines true \
    && sed -i "s#http://127.0.0.1:5000##g" .env \
    && yarn install \
    && yarn build

FROM nginx:stable-alpine AS cmdb-ui

ENV CMDB_VERSION 2.3.12

LABEL maintainer="zhoushun98@hotmail.com"

COPY --chown=nginx:nginx --from=ui-builder /cmdb-$CMDB_VERSION/cmdb-ui/dist /etc/nginx/html

ENV TZ=Asia/Shanghai LANG=C.UTF-8

RUN set -eux \
    && sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories \
    && apk --update --no-cache add tzdata \
    && ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && rm -f /etc/nginx/conf.d/default.conf \
    && rm -rf /var/cache/apk/*

# ================================= API ================================
FROM python:3.8.12-alpine AS api-builder

LABEL maintainer="zhoushun98@hotmail.com"

ENV CMDB_VERSION 2.3.12

RUN set -x \
    && sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories \
    && apk --update --no-cache add tzdata gcc musl-dev libffi-dev openldap-dev python3-dev jpeg-dev zlib-dev build-base curl \
    && curl -fsSLOJ https://mirror.ghproxy.com/https://github.com/veops/cmdb/archive/refs/tags/"$CMDB_VERSION".tar.gz \
    && tar zxf cmdb-"$CMDB_VERSION".tar.gz \
    && cd /cmdb-"$CMDB_VERSION"/cmdb-api/ \
    && pip install pipenv -i https://mirrors.aliyun.com/pypi/simple \
    && pipenv install \
    && pipenv requirements --dev > requirements.txt

FROM python:3.8.12-alpine AS cmdb-api

LABEL maintainer="zhoushun98@hotmail.com"

ENV CMDB_VERSION 2.3.12

COPY --from=api-builder /cmdb-"$CMDB_VERSION"/cmdb-api /cmdb

WORKDIR /cmdb

ENV TZ=Asia/Shanghai LANG=C.UTF-8

RUN set -eux \
    && sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories \
    && apk --update --no-cache add tzdata gcc musl-dev libffi-dev openldap-dev python3-dev jpeg-dev zlib-dev build-base curl \
    && ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && apkArch="$(apk --print-arch)" \
    && case "$apkArch" in \
        aarch64) \
            curl -fsSL https://mirror.ghproxy.com/https://github.com/ufoscout/docker-compose-wait/releases/download/2.12.1/wait_aarch64 -o /wait \
            ;; \
        x86_64) \
            curl -fsSL https://mirror.ghproxy.com/https://github.com/ufoscout/docker-compose-wait/releases/download/2.12.1/wait -o /wait \
            ;; \
        *) \
            echo error \
            ;; \
    esac \
    && chmod 755 /wait \
    && pip install --no-cache-dir -r requirements.txt \
    && cp ./settings.example.py settings.py \
    && sed -i "s#{user}:{password}@127.0.0.1:3306/{db}#cmdb:123456@mysql:3306/cmdb#g" settings.py \
    && sed -i "s#redis://127.0.0.1#redis://redis#g" settings.py \
    && sed -i "s#CACHE_REDIS_HOST = '127.0.0.1'#CACHE_REDIS_HOST = 'redis'#g" settings.py \
    && rm -rf /var/cache/apk/*
