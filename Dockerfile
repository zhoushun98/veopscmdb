FROM registry.cn-hangzhou.aliyuncs.com/zhoushun/cmdb-api:base AS builder

COPY ./cmdb-api /data/apps/cmdb

WORKDIR /data/apps/cmdb

RUN pip install pipenv -i https://mirrors.aliyun.com/pypi/simple &&\
    pipenv install &&\
    pipenv requirements --dev > /requirements.txt


FROM registry.cn-hangzhou.aliyuncs.com/zhoushun/cmdb-api:base AS cmdb-api

COPY ./cmdb-api /data/apps/cmdb

WORKDIR /data/apps/cmdb

COPY --from=builder /requirements.txt ./requirements.txt

RUN pip install  --no-cache-dir -r requirements.txt \
    && cp ./settings.example.py settings.py \
    && sed -i "s#{user}:{password}@127.0.0.1:3306/{db}#cmdb:123456@mysql:3306/cmdb#g" settings.py \
    && sed -i "s#redis://127.0.0.1#redis://redis#g" settings.py \
    && sed -i "s#CACHE_REDIS_HOST = '127.0.0.1'#CACHE_REDIS_HOST = 'redis'#g" settings.p
