# ================================= UI ================================
FROM node:16.20.2 AS ui-builder

COPY ./cmdb/cmdb-ui /data/apps/cmdb-ui

WORKDIR /data/apps/cmdb-ui

RUN yarn config set registry https://registry.npmmirror.com

RUN sed -i "s#http://127.0.0.1:5000##g" .env && yarn install  && yarn build

FROM nginx:1.24.0 AS cmdb-ui

ENV TZ=Asia/Shanghai LANG=C.UTF-8 LC_ALL=C.UTF-8

RUN ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && \
    echo ${TZ} > /etc/timezone

RUN mkdir /etc/nginx/html && rm -f /etc/nginx/conf.d/default.conf

COPY --from=ui-builder /data/apps/cmdb-ui/dist /etc/nginx/html/

# ================================= API ================================
FROM python:3.8.12-alpine AS api-builder

COPY ./cmdb/cmdb-api /data/apps/cmdb

WORKDIR /data/apps/cmdb

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories

RUN apk add --no-cache tzdata gcc musl-dev libffi-dev openldap-dev python3-dev jpeg-dev zlib-dev build-base

RUN pip install pipenv

RUN pipenv install

RUN pipenv requirements --dev > /requirements.txt

FROM python:3.8.12-alpine AS cmdb-api

COPY ./cmdb/cmdb-api /data/apps/cmdb

WORKDIR /data/apps/cmdb

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories

RUN apk add --no-cache tzdata gcc musl-dev libffi-dev openldap-dev python3-dev jpeg-dev zlib-dev build-base

ENV TZ=Asia/Shanghai

RUN cp /usr/share/zoneinfo/${TZ} /etc/localtime && \
    echo ${TZ} > /etc/timezone && \
    rm -rf /var/cache/apk/*

COPY --from=api-builder /requirements.txt /data/apps/cmdb/requirements.txt

RUN pip install  --no-cache-dir -r requirements.txt \
    && cp ./settings.example.py settings.py \
    && sed -i "s#{user}:{password}@127.0.0.1:3306/{db}#cmdb:123456@mysql:3306/cmdb#g" settings.py \
    && sed -i "s#redis://127.0.0.1#redis://redis#g" settings.py \
    && sed -i "s#CACHE_REDIS_HOST = '127.0.0.1'#CACHE_REDIS_HOST = 'redis'#g" settings.py
